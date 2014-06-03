

var expectstudenstatus = function(expectedstatus, key) {
  element.all(by.repeater(key + ' in students').column(key + '.status')).then(function(arr) {
    arr.forEach(function(a,wd, i) {
      expect(wd.getText()).toMatch(expectedstatus[i]);
    });
  });
};

it('should search across all fields when filtering with a string', function() {
  var searchText = element(by.model('searchText'));
  searchText.clear();
  searchText.sendKeys('m');
  expectstudentStatus(['Accept', 'Reject', 'pending'], 'student');

  searchText.clear();
  searchText.sendKeys('76');
  expectstudentStatus(['Accept', 'Reject'], 'student');
});


