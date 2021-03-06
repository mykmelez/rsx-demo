# rsx-demo
[![License: MPL 2.0](https://img.shields.io/badge/License-MPL%202.0-brightgreen.svg)](https://opensource.org/licenses/MPL-2.0)

Several demos for embedding [RSX](https://github.com/victorporof/rsx) and rendering DisplayLists generated by the [RSX Primitives](https://github.com/victorporof/rsx-primitives) library.

## Purpose
Quick and easy example code. For much more in-depth walkthroughs and documentation on how to build your own projects from scratch, see [this](https://github.com/victorporof/rsx-renderers).

## How to build
First, clone this repository recursively:
```
git clone git@github.com:victorporof/rsx-demo.git --recursive
```

Then, simply edit the `Cargo.toml` file to specify which target you want to build for.

### Building for web targets
This project is configured by default to build for the web. If you've already edited the `Cargo.toml` file, simply make sure you've specified a web target and the project isn't set up to compile as a library.

#### Cargo.toml
```toml
[features]
default = ["target-web"]
```

As prerequisites, you need to install [emscripten](https://github.com/juj/emsdk) as well as some `npm` development dependencies.
```
git clone https://github.com/juj/emsdk.git
cd emsdk
./emsdk update-tags
./emsdk install <sdk-of-your-choice>
./emsdk activate <sdk-of-your-choice>
source ./emsdk_env.sh (Windows: emsdk_env.bat)
```

If you get stuck, follow the steps outlined in the [official docs](https://kripken.github.io/emscripten-site/docs/getting_started/index.html) or the [github repo](https://github.com/juj/emsdk).

Then, simply
```
npm install
npm start -- --target=asmjs-unknown-emscripten
```

First time builds can take a very long time! Be patient.

### Building for iOS targets
Edit the `Cargo.toml` file to specify an iOS target and make this crate a library. As prerequisites, you need to install the appropriate architectures, as well as `cargo-lipo` and build [jemalloc](https://github.com/jemalloc/jemalloc).

#### Cargo.toml
```toml
[lib]
name = "rsx_demo"
path = "src/main.rs"
crate-type = ["staticlib", "cdylib"]

[features]
default = ["target-ios"]
```

Then, install the appropriate architectures, as well as `cargo-lipo`:
```
rustup target add aarch64-apple-ios armv7-apple-ios armv7s-apple-ios x86_64-apple-ios i386-apple-ios
cargo install cargo-lipo
```

Then simply:
```
cargo lipo --release
```

Then open XCode project, first installing the [CocoaPods](https://cocoapods.org) dependencies:
```
cd fixtures/ios/Example/
pod install
open Example.xcworkspace
```

### Building for native targets with WebRender
Edit the `Cargo.toml` file to specify a native target and make sure the project isn't set up to compile as a library.

#### Cargo.toml
```toml
[features]
default = ["target-servo"]
```

Then, simply
```
cargo run
```

## Write your own frontend
To make changes to the underlying Rust code, simply edit `main.rs` and `example.css` files inside the [src](https://github.com/victorporof/rsx-demo/tree/master/src) directory. For more examples and syntax, see the [RSX](https://github.com/victorporof/rsx) compiler plugin crate.

### Caveats
1. Editing CSS files require Rust files to be re-saved before building. This is because `cargo build` tries really hard not to rebuild if not necessary, and CSS files aren't on its radar.
2. Text doesn't contribute to layout. All text nodes have an intrinsic size of 0, until support is added to the layout tree builder. For now, this can be surprising at times when using flexbox.
3. Animation and user input isn't supported yet. Although animation and a render loop would be trivial to add, and user input support being possibly relatively straightforward as well, there's no implementation or example code yet. Stay tuned.
4. WebRender targets don't load any resources yet. This means that glyphs and images display as blank rectangles. Although resource loading would be trivial to add, there's no implementation or example code yet. Stay tuned.
