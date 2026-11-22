# TWRP Device Tree for Samsung Galaxy Tab 3 Lite 7.0 Wi-Fi (SM-T110 / goyawifi)

Modern TWRP (`twrp_goyawifi`) device tree based on the LineageOS 16.0 (`goyawifi`) tree, using the prebuilt Linux 4.19 `zImage` + `pxa986-samsung-goyawifi.dtb` in `kernel/`.

## Building

Place or symlink this directory at `device/samsung/goyawifi` in your TWRP minimal manifest tree, then:

```bash
source build/envsetup.sh
lunch twrp_goyawifi-eng
mka recoveryimage
```

Output: `out/target/product/goyawifi/recovery.img` (packed with `bootimg/goyawifi-mkbootimg.py` for Samsung S-Boot, <= 16 MiB).
