// Prevent image upload via Trix
document.addEventListener("trix-file-accept", function(event) {
  event.preventDefault();
});

// var editor = $element[0].editor;
// var events = angular.copy(editor.composition.delegate.inputController.events);

// // Prevent line break by Trix if user selects a mention.
// $element.on('textComplete:show', function() {
//   editor.composition.delegate.inputController.events.keypress = angular.noop;
//   editor.composition.delegate.inputController.events.keydown = angular.noop;
// });
// $element.on('textComplete:hide', function() {
//   editor.composition.delegate.inputController.events.keypress = events.keypress;
//   editor.composition.delegate.inputController.events.keydown = events.keydown;
// });