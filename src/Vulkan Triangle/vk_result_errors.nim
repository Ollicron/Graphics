#[
  The purpose of this module is just to store a function that prints out any resulting enum out of a VkResult
]#

proc resultToString*(r: VkResult): string =
  case r
  of VK_SUCCESS: "VK_SUCCESS"
  of VK_NOT_READY: "VK_NOT_READY"
  of VK_TIMEOUT: "VK_TIMEOUT"
  of VK_ERROR_OUT_OF_HOST_MEMORY: "VK_ERROR_OUT_OF_HOST_MEMORY"
  of VK_ERROR_OUT_OF_DEVICE_MEMORY: "VK_ERROR_OUT_OF_DEVICE_MEMORY"
  of VK_ERROR_INITIALIZATION_FAILED: "VK_ERROR_INITIALIZATION_FAILED"
  of VK_ERROR_LAYER_NOT_PRESENT: "VK_ERROR_LAYER_NOT_PRESENT"
  else: "Unknown VkResult: " & $r.int