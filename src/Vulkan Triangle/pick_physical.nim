#[
  The purpose of this module is to implement the function that picks the physical device for the program.
]#
import 
  nimgl/[vulkan],
  vk_result_errors



# Procedure to find a suitable device is suitable
proc checkForDevice(device:VkPhysicalDevice):bool=
  # In order to check if a device is good to work with we 
  discard

# Procedure to pick device
proc pickPhysicalDevice*(instance:VkInstance):VkPhysicalDevice=

  # First check to make sure we can enumerate physical devices
  var
    deviceCount: uint32 
    physCheck = vkEnumeratePhysicalDevices(instance, addr(deviceCount),nil)
  if physCheck != VK_SUCCESS:
    echo "Error: ",resultToString(physCheck)
    quit("Unable to count physical devices")
  if deviceCount == 0:
    quit("Failed to find suitable devices with Vulkan support!")


  # Then from the count actually grab the physical device
  var devices = newSeq[VkPhysicalDevice](deviceCount)
  physCheck = vkEnumeratePhysicalDevices(instance,addr(deviceCount),addr(devices[0]))

  for device in devices:
    if checkForDevice(device):
      result = device

