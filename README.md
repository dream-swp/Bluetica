# Bluetica

[![Swift](https://img.shields.io/badge/Swift-5.9+-orange.svg)](https://swift.org)
[![Platform](https://img.shields.io/badge/platform-iOS%20%7C%20macOS-lightgrey.svg)](https://developer.apple.com)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

一个简单的 Swift 蓝牙框架，基于 CoreBluetooth 封装，提供简洁优雅的链式 API 和常规的功能扩展。

## ✨ 特性

- 🔗 **链式调用** - 流畅的 API 设计，提升代码可读性
- 🎯 **类型安全** - 完整的泛型支持和类型检查
- 🔄 **状态管理** - 清晰的设备状态跟踪和管理
- 📦 **数据转换** - 丰富的数据格式转换工具（十六进制、二进制、Base64 等）
- 🎨 **SwiftUI 支持** - 与 SwiftUI 无缝集成
- 🔐 **权限管理** - 自动处理蓝牙权限和后台模式
- 📱 **多平台支持** - 支持 iOS 和 macOS

## 📋 要求

- iOS 13.0+ / macOS 10.15+
- Xcode 14.0+
- Swift 5.9+

## 📦 安装

### Swift Package Manager

在 Xcode 中添加包依赖：

```
https://github.com/dream-swp/Bluetica.git
```

或在 `Package.swift` 中添加：

```swift
dependencies: [
    .package(url: "https://github.com/dream-swp/Bluetica.git", from: "1.0.0")
]
```

## 🚀 快速开始

### 1. 配置权限

在 `Info.plist` 中添加蓝牙权限描述：

```xml
<key>NSBluetoothAlwaysUsageDescription</key>
<string>需要使用蓝牙与设备通信</string>
<key>NSBluetoothPeripheralUsageDescription</key>
<string>需要使用蓝牙与设备通信</string>
```

如需后台模式，添加：

```xml
<key>UIBackgroundModes</key>
<array>
    <string>bluetooth-central</string>
</array>
```

### 2. 初始化蓝牙管理器

```swift
import Bluetica

// 获取单例实例
let bluetica = Bluetica.default
```

### 3. 配置扫描参数

```swift
// 配置中心设备
bluetica.central
    .config { config in
        config
            // 设置要扫描的服务 UUID（可选）
            .services { [CBUUID(string: "180D")] }
            // 设置扫描选项
            .scanOptions { [CBCentralManagerScanOptionAllowDuplicatesKey: false] }
            // 设置过滤规则
            .filter { .identifier }
    }
```

### 4. 扫描设备

```swift
// 开始扫描
bluetica.central
    .discover { device, central in
        print("发现设备: \(device.name)")
        print("RSSI: \(device.rssi)")
        print("标识符: \(device.identifier)")
    }
    .start()

// 停止扫描
bluetica.central.stop
```

### 5. 连接设备

```swift
bluetica.central
    .connect(device) { result in
        switch result {
        case .success(let device):
            print("连接成功: \(device.name)")
        case .failure(let error):
            print("连接失败: \(error)")
        }
    }
```

### 6. 发现服务和特征

```swift
bluetica.central
    .discoverServices { device, peripheral, error in
        guard error == nil else { return }
        print("发现 \(peripheral.services?.count ?? 0) 个服务")
    }
    .discoverCharacteristics { device, update, peripheral, service, error in
        guard error == nil else { return }
        print("发现特征: \(service.characteristics?.count ?? 0)")
    }
```

### 7. 读写数据

```swift
// 写入数据
let data = "Hello".data(using: .utf8)!
bluetica.central
    .write(data, for: characteristic, type: .withResponse)
    .writeValue { update, peripheral, characteristic, error in
        if error == nil {
            print("写入成功")
        }
    }

// 读取数据
bluetica.central
    .read(for: characteristic)
    .updateValue { data, info in
        if let data = data, let string = String(data: data, encoding: .utf8) {
            print("读取到数据: \(string)")
        }
    }

// 订阅通知
bluetica.central
    .notify(true, for: characteristic)
    .updateValue { data, info in
        if let data = data {
            print("收到通知数据: \(data.convert.hex)")
        }
    }
```

## 📚 核心功能

### 设备管理

```swift
// 获取已连接设备列表
let connectedDevices = bluetica.blueticaCentral.peripherals.connected

// 断开设备连接
bluetica.central.cancel(device)

// 检查设备状态
if device.isConnected {
    print("设备已连接")
}
```

### 数据转换

Bluetica 提供了强大的数据转换工具：

```swift
// Data 转换
let data = Data([0x48, 0x65, 0x6C, 0x6C, 0x6F])

// 转十六进制
print(data.convert.hex) // "48 65 6C 6C 6F"

// 转十进制
print(data.convert.decimal) // "72, 101, 108, 108, 111"

// 转字符串
print(data.convert.value) // "Hello"

// 转二进制
print(data.convert.binary()) // "01001000 01100101 01101100 01101100 01101111"

// 转 Base64
print(data.convert.base64) // "SGVsbG8="

// String 转换
let hexString = "48656C6C6F"
let data = hexString.convert.hex
print(String(data: data, encoding: .utf8)!) // "Hello"

// 十进制转换
let decimalString = "72,101,108,108,111"
let data2 = decimalString.convert.decimal
print(String(data: data2, encoding: .utf8)!) // "Hello"
```

### 事件处理

```swift
bluetica.central
    // 监听蓝牙状态变化
    .state { manager, central in
        switch central.state {
        case .poweredOn:
            print("蓝牙已开启")
        case .poweredOff:
            print("蓝牙已关闭")
        default:
            break
        }
    }
    // 连接成功回调
    .connectSuccess { manager, device, central, peripheral in
        print("设备连接成功: \(device?.name ?? "")")
    }
    // 连接失败回调
    .connectFailure { manager, device, central, peripheral, error in
        print("连接失败: \(error?.localizedDescription ?? "")")
    }
    // 断开连接回调
    .disconnectPeripheral { manager, device, central, peripheral, error in
        print("设备已断开")
    }
```

### 配置选项

```swift
// 管理器配置
bluetica.central.manager { config in
    config
        .queue { DispatchQueue.main }
        .options { [:] }
}

// 外设配置
bluetica.central.peripheral { config in
    config
        .discoverServices { nil } // nil 表示发现所有服务
        .discoverCharacteristics { nil }
        .isAutoDiscoverServices { true }
        .isAutoDiscoverCharacteristics { true }
}
```

## 🎯 高级用法

### 过滤规则

```swift
// 按名称过滤
bluetica.central.config { config in
    config.filter { .name }
}

// 按标识符过滤
bluetica.central.config { config in
    config.filter { .identifier }
}

// 自定义过滤
bluetica.central.config { config in
    config.filter { .custom(false) }
}
```

### 后台模式

```swift
// 检查是否支持后台模式
if bluetica.verify.isBackgroundMode {
    print("支持后台蓝牙")
}

// 检查蓝牙授权状态
bluetica.verify.isBluetoothAuthorization()
```

### SwiftUI 集成

```swift
import SwiftUI
import Bluetica

struct ContentView: View {
    @StateObject private var viewModel = BluetoothViewModel()
    
    var body: some View {
        List(viewModel.devices) { device in
            HStack {
                Text(device.name)
                Spacer()
                Text("RSSI: \(device.rssi)")
            }
            .onTapGesture {
                viewModel.connect(device)
            }
        }
        .onAppear {
            viewModel.startScanning()
        }
    }
}

class BluetoothViewModel: ObservableObject {
    @Published var devices: [BlueticaCentral.Device] = []
    private let bluetica = Bluetica.default
    
    func startScanning() {
        bluetica.central
            .discover { [weak self] device, _ in
                if let index = self?.devices.firstIndex(of: device) {
                    self?.devices[index] = device
                } else {
                    self?.devices.append(device)
                }
            }
            .start()
    }
    
    func connect(_ device: BlueticaCentral.Device) {
        bluetica.central.connect(device) { result in
            // 处理连接结果
        }
    }
}
```

## 📖 API 文档

### Bluetica 类

主要的蓝牙管理类，采用单例模式。

- `Bluetica.default` - 获取单例实例
- `central` - 中心设备操作链式入口

### BlueticaCentral 类

中心设备管理类，提供扫描、连接、数据读写等功能。

**配置方法：**
- `config(_ handler:)` - 配置中心设备
- `manager(_ handler:)` - 配置管理器
- `peripheral(_ handler:)` - 配置外设

**扫描方法：**
- `start()` - 开始扫描
- `stop` - 停止扫描
- `discover(_ handler:)` - 发现设备回调

**连接方法：**
- `connect(_:handler:)` - 连接设备
- `cancel(_:)` - 断开连接

**数据操作：**
- `read(for:)` - 读取特征值
- `write(_:for:type:)` - 写入特征值
- `notify(_:for:)` - 订阅/取消订阅通知

**事件回调：**
- `state(_:)` - 蓝牙状态变化
- `connectSuccess(_:)` - 连接成功
- `connectFailure(_:)` - 连接失败
- `disconnectPeripheral(_:)` - 断开连接
- `discoverServices(_:)` - 发现服务
- `discoverCharacteristics(_:)` - 发现特征
- `updateValue(_:)` - 特征值更新
- `writeValue(_:)` - 写入完成

### Device 模型

设备信息模型。

**属性：**
- `id: UUID` - 设备标识符
- `name: String` - 设备名称
- `rssi: NSNumber` - 信号强度
- `state: PeripheralState` - 连接状态
- `isConnected: Bool` - 是否已连接
- `services: [Service]` - 服务列表
- `characteristics: [Characteristic]` - 特征列表

### 数据转换

**Data 扩展：**
- `.convert.hex` - 转十六进制
- `.convert.decimal` - 转十进制
- `.convert.binary()` - 转二进制
- `.convert.value` - 转字符串
- `.convert.ascii()` - 转 ASCII
- `.convert.base64` - 转 Base64

**String 扩展：**
- `.convert.data` - 转 Data
- `.convert.hex` - 从十六进制转换
- `.convert.decimal` - 从十进制转换
- `.convert.binary` - 从二进制转换
- `.convert.base64()` - 从 Base64 转换

## 🔍 示例项目

项目包含完整的示例应用，演示了所有主要功能：

```
Example/
├── ExampleApp.swift           # 应用入口
├── AppEntryView.swift         # 主界面
└── Code/
    ├── Model/                 # 数据模型
    ├── ViewModel/             # 视图模型
    └── Views/                 # 视图组件
        ├── Main/              # 主视图
        ├── Device/            # 设备列表
        └── Card/              # 卡片组件
```

运行示例项目：

1. 打开 `Example/Example.xcodeproj`
2. 选择目标设备或模拟器
3. 运行项目

## 📄 许可证

Bluetica 采用 MIT 许可证。详见 [LICENSE](LICENSE) 文件。

## 👨‍💻 作者

Dream - [GitHub](https://github.com/dream-swp)

## 🙏 致谢

感谢所有为这个项目做出贡献的开发者。

---











