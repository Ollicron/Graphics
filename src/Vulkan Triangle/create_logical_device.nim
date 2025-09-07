#[
The purpose of this module is to create the logical device. We want to insert the correct queue family into it.
]#
import 
  nimgl/[vulkan],
  std/[options],
  queue_families,
  vk_result_errors


proc createLogicalDevice*(device:VkPhysicalDevice):VkDevice=
  # Creating a logical device is similar to creating an instance, in that we need a structure defined with a createInfo type.

  # We need to first get the right family from the physical device that we want to attach to the logical device.
  
  # Why optional? Why not optional? 
  var graphicsFamily:Option[uint32] = findQueueFamilies(device)

  # We are going to need a queueCreateInfo structure to put into the logical device. (Note that the priority is mandatory.)
  var queueCreateInfo:VkDeviceQueueCreateInfo
  queueCreateInfo.sType = VK_STRUCTURE_TYPE_DEVICE_QUEUE_CREATE_INFO
  queueCreateInfo.queueFamilyIndex = graphicsFamily.get()
  queueCreateInfo.queueCount = 1
  let queuePriority = 1.0f
  queueCreateInfo.pQueuePriorities = addr(queuePriority)

  # Next we need to specify the set of device features we will be using. These are gotten from vkGetPhysicalDeviceFeatures back when selecting the physical device. *for now we leave this alone...

  var deviceFeatures:VkPhysicalDeviceFeatures

  # Now we create the logical device
  var createInfo:VkDeviceCreateInfo
  createInfo.sType = VK_STRUCTURE_TYPE_DEVICE_CREATE_INFO
  createInfo.pQueueCreateInfos= addr(queueCreateInfo)
  createInfo.queueCreateInfoCount = 1
  createInfo.pEnabledFeatures =addr(deviceFeatures)

  #[
  vkCreateDevice Constructor for reference.

  VkResult vkCreateDevice(
    VkPhysicalDevice physicalDevice,      // The GPU you want to create a logical device for
    const VkDeviceCreateInfo* pCreateInfo, // Pointer to a struct describing the device you want
    const VkAllocationCallbacks* pAllocator, // Optional custom allocator (usually nullptr)
    VkDevice* pDevice                      // OUT: handle to the new logical device
  );
  ]#

  var createCheck = vkCreateDevice(device, addr(createInfo), nil, addr(result))

  if createCheck != VK_SUCCESS:
    echo "Error:",resultToString(createCheck)
    quit("Error in creating logical device!")
  else:
    echo "Created logical device."
