# binday

A 3D-printed smart display for bin collection day reminders.

## What This Design Does

This is a physical stage/platform that sits on your counter or shelf and reminds you which bins need to go out on collection day. The design features:

- **Two bin positions** on top of the platform (e.g., recycling and general waste)
- **LED indicators** that shine upward through the lid, positioned at the front of each bin location
- **"BINDAY" lettering** mounted on the front face for clear identification
- **ESP32 microcontroller** inside that controls the LEDs based on your collection schedule
- **Smart illumination**: The appropriate LED lights up to indicate which bin needs to go out that day

### How It Works

1. Place small decorative bins (or bin representations) on the marked positions on the lid
2. The ESP32 connects to WiFi and tracks your bin collection schedule
3. On collection day, the LED under the corresponding bin illuminates
4. The upward-facing LED shines through a hole in the lid, making it immediately obvious which bin goes out
5. Never miss bin day again!

### Design Features

- **Dimensions**: 226mm × 107mm × 31mm (assembled)
- **Upward LED design**: Better visibility with light shining up where the bins are
- **Protected electronics**: LEDs and ESP32 housed in a split base/lid design
- **Cable management**: Built-in channels for clean wire routing
- **Letter mounting**: Push-fit letter pins for "BINDAY" branding

## ⚠️ Important Notice

This project was AI-generated and may contain issues, bugs, or incomplete functionality. If you're using this code, please help ensure it's correct by:

- Testing thoroughly before use
- Reporting any issues you find
- Contributing fixes and improvements
- Reviewing the code for security and correctness

**Use at your own risk.** Contributions and feedback are welcome!

## Installation

```bash
npm install
```

## Usage

```bash
npm start
```

## Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

## License

[MIT](LICENSE)
