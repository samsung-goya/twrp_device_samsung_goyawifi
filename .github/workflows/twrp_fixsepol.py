with open("external/sepolicy/tools/Android.mk", 'r+') as file:
    content = file.read()
    file.seek(0)
    file.write(content.replace("-Werror", ""))
    file.truncate()
