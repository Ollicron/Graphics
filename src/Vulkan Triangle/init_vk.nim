#[
  The purpose of this module is to initialize vulkan and all of its components for the application.
]# 

import 
  nimgl/[glfw,vulkan]
  #validation_layers

proc checkExtensions()=
  # We need to make sure that Vulkan loads the necessary extensions.
  var extensionCount:uint32 = 0

  var enumExtensions = vkEnumerateInstanceExtensionProperties(nil,addr(extensionCount),nil)
  if enumExtensions != VK_SUCCESS:
    quit("Unable to enumerate instance extensions")

  var extensions = newSeq[VkExtensionProperties](extensionCount)
  
  enumExtensions = vkEnumerateInstanceExtensionProperties(nil,addr(extensionCount),addr(extensions[0]))

  # List the available extensions (note extensions come as C style char arrays)
  echo "Available extensions:"
  for ext in extensions:
    # extensionName is an array[256, char]
    let name = $cast[cstring](addr ext.extensionName)
    echo name


proc createInstance():VkInstance =
  var 
    appInfo:VkApplicationInfo
    createInfo:VkInstanceCreateInfo
  
  # Create the application info variable 
  appInfo.sType = VK_STRUCTURE_TYPE_APPLICATION_INFO
  appInfo.pApplicationName = "Hello Triangle"
  appInfo.applicationVersion = vkMakeVersion(1, 0, 0)
  appInfo.pEngineName = "No Engine"
  appInfo.engineVersion = vkMakeVersion(1, 0, 0)
  appInfo.apiVersion = vkApiVersion1_2

  # Create the instance info
  createInfo.sType = VK_STRUCTURE_TYPE_INSTANCE_CREATE_INFO
  createInfo.pApplicationInfo = addr(appInfo)
  createInfo.enabledLayerCount = 0

  # We need to get the extensions from Vulkan that are required in order to work with GLFW windows. For that it is assumed we already have a GLFW instance in the program for this function to work.
  var glfwExtensionCount:uint32 = 0
  let glfwExtensions = glfwGetRequiredInstanceExtensions(addr(glfwExtensionCount))

  createInfo.enabledExtensionCount = glfwExtensionCount
  createInfo.ppEnabledExtensionNames = glfwExtensions

  checkExtensions()

  let instCrtRst = vkCreateInstance(addr(createInfo),nil,addr(result))
  if instCrtRst != VK_SUCCESS:
    quit("Error in creating instance!")


# Procedure to initialize Vulkan
proc initVulkan*():VkInstance=
  let initBool = vkInit()
  if initBool == false:
    quit("Could not initialize Vulkan, check to make sure it is installed properly!")

  result = createInstance()
