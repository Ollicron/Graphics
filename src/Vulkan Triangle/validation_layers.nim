import nimgl/vulkan, strutils

proc hasValidationLayer(layerName: cstring): bool =
  var layerCount: uint32 = 0

  # get number of available layers
  if vkEnumerateInstanceLayerProperties(addr(layerCount), nil) != VK_SUCCESS:
    quit("Could not enumerate Vulkan layers")

  # allocate array for layer properties
  var layers = newSeq[VkLayerProperties](layerCount)
  discard vkEnumerateInstanceLayerProperties(addr(layerCount), addr(layers[0]))

  # check if our layer exists
  for layer in layers:
    if $cast[cstring](addr layer.layerName) == layerName:
      return true

  return false

when isMainModule:
  let bkinit = vkInit()
  # usage
  if hasValidationLayer("VK_LAYER_KHRONOS_validation".cstring):
    echo "You’ve got the layer!"
  else:
    echo "Nope, layer not installed."

  proc listLayers() =
    var layerCount: uint32 = 0
    if vkEnumerateInstanceLayerProperties(addr(layerCount), nil) != VK_SUCCESS:
      quit("Failed to get layer count")

    var layers = newSeq[VkLayerProperties](layerCount)
    discard vkEnumerateInstanceLayerProperties(addr(layerCount), addr(layers[0]))

    for layer in layers:
      echo $cast[cstring](addr layer.layerName)
  
  listLayers()