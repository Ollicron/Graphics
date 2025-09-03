import nimgl/vulkan

# Define validation layers to be used here!
let validationLayers*:seq[cstring] = @[cstring("VK_LAYER_KHRONOS_validation")]

proc hasValidationLayer*(layerName: cstring): bool =
  var layerCount: uint32 = 0

  # get number of available layers
  if vkEnumerateInstanceLayerProperties(addr(layerCount), nil) != VK_SUCCESS:
    quit("Could not enumerate Vulkan layers")

  # Allocate array for layer properties
  var layers = newSeq[VkLayerProperties](layerCount)
  discard vkEnumerateInstanceLayerProperties(addr(layerCount), addr(layers[0]))

  # check if our layer exists
  for layer in layers:
    if $cast[cstring](addr layer.layerName) == $layerName:
      echo "Layer to be enabled:",$layerName
      return true
      
  return false