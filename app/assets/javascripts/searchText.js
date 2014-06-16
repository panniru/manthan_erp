
it('should search across all fields when filtering with a string', function() {
    var searchText = element(by.model('searchText'));
    searchText.clear();
    searchText.sendKeys('m');
   // expectstudentStatus(['Accept', 'Reject', 'pending'], 'student');

    searchText.clear();
    searchText.sendKeys('76');
   // expectstudentStatus(['Accept', 'Reject'], 'student');
});
