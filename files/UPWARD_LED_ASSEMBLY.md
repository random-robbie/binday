# Bin Day Stage - Upward LED Assembly Guide

## New Design Overview
LEDs now shine **UPWARD** through holes in the lid, positioned at the front edge of each bin location. This design provides better visibility and cleaner front aesthetics.

## Component Files

### Main Parts
- `base_upward_leds.stl` - Base with upward LED holders (651KB)
- `lid_upward_leds.stl` - Lid with LED holes (362KB)
- Letter files (B, I, N, D, A, Y) - Mount on front face

### Source File
- `bin_stage_upward_leds.scad` - OpenSCAD source for customization

## LED Mounting System

### How It Works
1. **LED Holders**: Four posts in base create a cradle for each LED PCB
2. **PCB Position**: LEDs sit horizontally, facing upward
3. **Lid Pressure**: When lid is attached, pressure rings hold LEDs in place
4. **Light Path**: LEDs shine up through 10mm holes in lid

### LED Positions
- **LED 1**: Center front of left bin area
- **LED 2**: Center front of right bin area
- **Distance from front**: 15mm from front bin edge
- **Light Direction**: Straight up to illuminate bin area

## Assembly Instructions

### Step 1: Prepare LEDs
1. Test both LED modules before installation
2. Solder wires to each LED PCB if not pre-wired:
   - Red wire → VCC
   - Black wire → GND
   - Data wire(s) → Signal pins
3. Make wires long enough to reach ESP32 (about 100mm)

### Step 2: Install Electronics in Base

#### LED Installation:
1. **Place LED 1** (left position):
   - Drop PCB into the four-post holder
   - PCB corners should rest in the notches
   - LED component faces UP through center hole
   - Route wires through cable channel

2. **Place LED 2** (right position):
   - Same process as LED 1
   - Ensure LED is centered in holder

#### ESP32 Installation:
1. Position ESP32 on center mounting posts
2. Secure with M2.5 screws
3. Don't overtighten (can crack posts)

#### Wiring:
1. Route LED 1 wires through left channel
2. Route LED 2 wires through right channel
3. Connect to ESP32:
   ```
   LED 1: VCC→3.3V, GND→GND, Data→GPIO18
   LED 2: VCC→3.3V, GND→GND, Data→GPIO21
   ```
4. USB cable exits through rear port

### Step 3: Install Letters
1. Letters mount on FRONT face of base
2. Push each letter's pins into holes
3. Order: B-I-N (space) D-A-Y
4. Letters should sit flush against face

### Step 4: Attach Lid

**IMPORTANT**: The lid holds the LEDs in place!

1. **Check LED alignment**:
   - LEDs should be centered in their holders
   - No wires blocking LED components

2. **Position lid carefully**:
   - Align LED holes with LED positions
   - Pressure rings on lid underside will contact PCBs

3. **Secure with screws**:
   - Start all 6 screws loosely
   - Tighten gradually in cross pattern
   - Lid should sit flush with base top

4. **Test fit**:
   - Look through LED holes - should see LED clearly
   - If LED seems off-center, loosen lid and adjust

### Step 5: Final Testing
1. Connect USB power
2. Upload test code to ESP32
3. Both LEDs should shine upward through holes
4. Place bins on top - light should illuminate front area

## Critical Measurements

### LED PCB Holder
- Post spacing: 18.8mm x 16mm
- Holder height: 15mm from base
- PCB sits at: 18mm from base
- LED top at: ~21mm from base

### Lid LED Holes
- Hole diameter: 10mm
- Decorative ring: 16mm diameter
- Pressure ring (underside): 20.8mm diameter
- Ring depth: 2mm below lid

## Troubleshooting

### LED Not Centered in Hole
- Loosen lid screws
- Adjust LED position in holder
- Retighten lid gradually

### LED Too Dim
- Check if lid pressure ring is blocking LED
- Verify power connections
- Ensure LED is facing directly upward

### LED Falls Out When Lid Removed
- Normal - lid holds LEDs in place
- Handle base carefully when lid is off
- Consider small dab of hot glue if needed

### Wires Getting Pinched
- Route through channels properly
- Don't let wires cross LED holders
- Use cable ties in channels if needed

## Advantages of Upward Design

1. **Better Visibility**: Light shines up where bins are
2. **Protected LEDs**: Recessed in lid holes
3. **Clean Front**: Only letters visible from front
4. **Easy Access**: Remove lid to access all electronics
5. **Natural Indication**: Light at base of each bin

## Example Test Code

```cpp
// Test both upward-facing LEDs
#define LED1_PIN 18  // Left bin
#define LED2_PIN 21  // Right bin

void setup() {
  pinMode(LED1_PIN, OUTPUT);
  pinMode(LED2_PIN, OUTPUT);
}

void loop() {
  // Alternate LEDs
  digitalWrite(LED1_PIN, HIGH);
  digitalWrite(LED2_PIN, LOW);
  delay(500);
  
  digitalWrite(LED1_PIN, LOW);
  digitalWrite(LED2_PIN, HIGH);
  delay(500);
}
```

## Printing Settings

### Base (with LED holders)
- **Support**: May need support for LED holder overhangs
- **Support type**: Tree supports recommended
- **Layer height**: 0.2mm
- **Infill**: 25-30%

### Lid (with LED holes)
- **Support**: None needed
- **Layer height**: 0.2mm
- **Infill**: 20-25%
- **First layer**: Ensure good adhesion for pressure rings

## Hardware List

### Required:
- 6x M3 x 12mm screws (lid attachment)
- 4x M2.5 x 6mm screws (ESP32)
- 2x LED modules (14.8mm x 12mm PCB)
- 1x ESP32-WROOM-32
- Jumper wires
- USB cable

### Optional:
- Hot glue (LED security)
- Cable ties (wire management)
- Rubber feet (base stability)

## LED Module Compatibility

Works with LED modules that have:
- PCB size: 14.8mm x 12mm (or smaller)
- Upward-facing LED component
- 4 connection pins (VCC, GND, Data, Clock/Extra)

Compatible types:
- Single color LEDs
- RGB LEDs (WS2812B style)
- Small LED arrays

## Safety Notes

- LEDs face upward - avoid looking directly into them
- Secure all connections before closing lid
- Ensure no shorts between LED pins
- Keep USB cable accessible for updates

## Dimensions

**Assembled**:
- Width: 226mm
- Depth: 107mm
- Height: 31mm

**LED Positions**:
- LED 1: X=64mm, Y=15mm from origin
- LED 2: X=162mm, Y=15mm from origin
- Separation: 98mm between LEDs
