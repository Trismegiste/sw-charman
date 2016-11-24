var NephilimRendering = function (charac) {
    this.character = charac;
}

NephilimRendering.prototype = {
    getDocument: function () {
        return {content: 'This is an sample PDF printed with pdfMake'};
    }
}