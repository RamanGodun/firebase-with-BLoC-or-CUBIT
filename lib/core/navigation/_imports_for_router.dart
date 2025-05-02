import 'package:go_router/go_router.dart';
import '../di/di_container.dart';
import '../../features/auth_bloc/auth_bloc.dart';
import '../../features/profile/profile_page.dart';
import '../../features/sign_in/sign_in_page.dart';
import '../../features/sign_up/signup_page.dart';
import '../../presentation/pages/change_password_page.dart';
import '../../presentation/pages/_home_page.dart';
import '../../presentation/pages/page_not_found.dart';
import '../../presentation/pages/password_reset_page.dart';
import '../../presentation/pages/splash_page.dart';
import '../../presentation/pages/verify_email_page.dart';
import '../../presentation/widgets/app_scaffold.dart';
import 'utils/page_transition.dart';
import 'utils/router_redirect.dart';
import 'utils/router_refresher.dart' show GoRouterRefresher;

part 'routes_names.dart';
part 'router.dart';
