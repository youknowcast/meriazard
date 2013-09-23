
/*
 * GET home page.
 */

exports.index = function(req, res){
  res.render('user_index', { title: 'Meriazard' });
};