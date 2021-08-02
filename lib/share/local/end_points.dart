const  LOGIN ='login';

const  HOME='home';

const  CATEGORIES='categories';

const FAVORITES='favorites';

const PROFILE='profile';

const REGISTER='register';

const UPDATEPROFILE='update-profile';

const SEARCH='products/search';


//بتجيب الداتا كامله

void printFullText(String text)
{
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

  String token='';