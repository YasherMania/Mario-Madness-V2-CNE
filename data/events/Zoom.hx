function onEvent(eventEvent){
    if (eventEvent.event.name == "Zoom"){
        var types = switch(eventEvent.event.params[1]){
            case 'Add': defaultCamZoom += eventEvent.event.params[0];
            case 'Subtract': defaultCamZoom -= eventEvent.event.params[0];
            case 'Multiply': defaultCamZoom *= eventEvent.event.params[0];
            case 'Divide': defaultCamZoom /= eventEvent.event.params[0];
            case 'Set': defaultCamZoom = eventEvent.event.params[0];
        };
    }
}