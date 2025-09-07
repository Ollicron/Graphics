import 
  init_glfw,
  init_vk,
  pick_physical_device,
  create_logical_device,
  cleanup,
  termstyle


proc main()=
  try:
    let 
      window = initWindow()
      vkInstance = initVulkan()
      device = pickPhysicalDevice(vkInstance)
      logDevice = createLogicalDevice(device)


    mainLoop(window)
    cleanup(window,vkInstance,logDevice)
  except:
    quit("Could not start application")

main()