import 
  init_glfw,
  init_vk,
  pick_physical

proc main()=
  try:
    let window = initWindow()
    let vkInstance = initVulkan()
    let device = pickPhysicalDevice(vkInstance)

    mainLoop(window)
    cleanup(window,vkInstance)
  except:
    quit("Could not start application")

main()