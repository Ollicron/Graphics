#[
  The purpose of this module is to implement procedures to create the window for the application using GLFW
]#

import nimgl/[glfw,vulkan]

#[ Constants ]#
const Width:int32 = 800
const Height:int32 = 600

# Proc to create window
proc initWindow*():GLFWWindow =
  let initBool = glfwInit()
  if initBool == false:
    quit("GLFW is either not properly installed or missing.")

  # By default the context for GLFW is to use OpenGL we need to tell it not to use it.
  glfwWindowHint(GLFWClientApi, GLFWNoApi)

  # Make our window not resizable.
  glfwWindowHint(GLFWResizable,GLFWFalse)

  # Make our window
  let window = glfwCreateWindow(Width,Height, "Vulkan", nil, nil)
  result = window

# Proc to keep application running
proc mainLoop*(window:GLFWWindow) =
  while windowShouldClose(window) == false:
    glfwPollEvents()

# Proc to cleanup the window to be destroyed
proc cleanup*(window:GLFWWindow, instance:VkInstance) =
  vkDestroyInstance(instance,nil)
  destroyWindow(window)
  glfwTerminate()