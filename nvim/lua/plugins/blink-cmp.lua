return {
  "saghen/blink.cmp",
  -- use a release tag to download pre-built binaries
  version = "1.*",
  -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
  -- build = 'cargo build --release',
  -- If you use nix, you can build from source using latest nightly rust with:
  -- build = 'nix run .#build-plugin',

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    -- Rust vs Lua implementation
    -- Prebuilt binaries are included in the releases and automatically downloaded when on a release tag (see below). However, for unsupported systems or when the download fails, it will automatically fallback to a Lua implementation, emitting a warning. You may suppress this warning or enforce the Lua or Rust implementation.
    --
    -- prefer_rust_with_warning If available, use the Rust implementation, automatically downloading prebuilt binaries on supported systems. Fallback to the Lua implementation when not available, emitting a warning message.
    -- prefer_rust: If available, use the Rust implementation, automatically downloading prebuilt binaries on supported systems. Fallback to the Lua implementation when not available.
    -- rust: Always use the Rust implementation, automatically downloading prebuilt binaries on supported systems. Error if not available.
    -- lua: Always use the Lua implementation
    fuzzy = { implementation = "prefer_rust" },
  },
}
