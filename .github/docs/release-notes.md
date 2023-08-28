## PPM Build 47

- Updated pastpaper lists for A Level and IGCSE.
- Updated dependencies for security.
- Added GitHub Actions workflow to test each commit, and automatically release new versions. (thanks @WangEdward)

See [commit history](https://github.com/SCIEDEV/PastPaperMaster/commits/main) for further information.

## Download instructions

Currently, none of the binaries are signed due to a lack of developer certificate. (which is expensive!)

- `ppm-macos-vxxx.tar.gz` macOS Universal application.
  - Since this application is not signed, you may need to click the <kbd>Open anyway</kbd> button in System Settings » Privacy & Security.
  - Opening this app anyway should be secure since this app is already open source; if you are still concerned of security, just build this app from source and use that binary.
- `ppm-windows-vxxx.zip` Windows x64 application.
  - Again, this application is not signed. You may see Windows Defender warning about this application.
- `ppm-linux-vxxx.tar.gz` Linux x64 application.
