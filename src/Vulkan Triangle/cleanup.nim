#[
The purpose of this module is to simply contain a procedure for the cleanup operations...for everything.
]#

import nimgl/[vulkan,glfw]

# Proc to cleanup the window to be destroyed
proc cleanup*(window:GLFWWindow, instance:VkInstance, logDevice:VkDevice) =
  vkDestroyDevice(logDevice,nil)
  vkDestroyInstance(instance,nil)
  destroyWindow(window)
  glfwTerminate()