

  # 注意：CMakeLists.txt 添加以下内容支持Android编译 [reference link]{https://github.com/Haivision/srt/pull/1053?w=1}
‘’‘
elseif(ANDROID)
  add_definitions(-DANDROID=1)
  message(STATUS "DETECTED SYSTEM:ANDROID; ANDROID=1")
’’‘

  # Init Repository 初始化库

  ```
  ./init-openssl.sh armv7a | all
  ```


  # Clean Repository Cache 清理库缓存

  ```
  ./init-openssl.sh clean
  ```

  # Build Library 构建库

  ```
  ./compile-openssl.sh armv7a | all
  ```

  # Check Output 查看输出结果

  ```
  open ./product
  ```
