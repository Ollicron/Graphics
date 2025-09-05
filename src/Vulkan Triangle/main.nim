import 
  init_glfw,
  init_vk,
  pick_physical_device,
  queue_families

proc main()=
  try:
    let 
      window = initWindow()
      vkInstance = initVulkan()
      device = pickPhysicalDevice(vkInstance)

    findQueueFamilies(device)


    mainLoop(window)
    cleanup(window,vkInstance)
  except:
    quit("Could not start application")

main()