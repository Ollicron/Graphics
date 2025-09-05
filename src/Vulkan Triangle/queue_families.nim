#[ 
The purpose of this module is queue families, and possibly everything about them.
]#


#[
It is helpful to have this table on hand for the individual flags for each queue

| Bit | Value | Meaning (queue flag)          |
| --- | ----- | ----------------------------- |
| 0   | 1     | `VK_QUEUE_GRAPHICS_BIT`       |
| 1   | 2     | `VK_QUEUE_COMPUTE_BIT`        |
| 2   | 4     | `VK_QUEUE_TRANSFER_BIT`       |
| 3   | 8     | `VK_QUEUE_SPARSE_BINDING_BIT` |
| 4+  | 16+   | unused in this case           |
]#

import 
  options,
  nimgl/[vulkan]

var graphicsFamily:Option[uint32]

# This procedure is just to find a proper queue family, in this case we want a family that has the Graphics bit turned on
proc findQueueFamilies*(device:VkPhysicalDevice):Option[seq[uint32]]{.discardable.}=
  var queueFamilyCount:uint32 = 0

  # As always we want to first get the count of something before populating anything. And then populate a carrier.
  vkGetPhysicalDeviceQueueFamilyProperties(device, addr(queueFamilyCount),nil)

  echo "Family count:", queueFamilyCount


  var queueFamilies = newSeq[VkQueueFamilyProperties](queueFamilyCount)
  vkGetPhysicalDeviceQueueFamilyProperties(device, addr(queueFamilyCount), addr(queueFamilies[0]))

  for i,family in queueFamilies:
    echo $family.queueFlags.repr
    if (cast[uint32](family.queueFlags) and cast[uint32](VK_QUEUE_GRAPHICS_BIT)) != 0:
      graphicsFamily = some(uint32(i))

  if graphicsFamily.isSome():
    echo graphicsFamily.repr

