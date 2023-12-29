function onEvent(_){
    if (_.event.name == "Camera Bumping"){
        camZoomingInterval = _.event.params[0];
        camZoomingStrength = _.event.params[1];
    }
}