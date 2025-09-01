import 
  init_glfw,
  init_vk

proc main()=
  try:
    let window = initWindow()
    let vkInstance = initVulkan()
    mainLoop(window)
    cleanup(window,vkInstance)
    discard
  except:
    quit("Could not start application")

main()