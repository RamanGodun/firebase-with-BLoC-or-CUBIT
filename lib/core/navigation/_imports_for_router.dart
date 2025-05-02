import 'package:go_router/go_router.dart';
import '../../core/di/injection.dart';
import '../../features/auth_bloc/auth_bloc.dart';
import '../../features/profile/profile_page.dart';
import '../../features/sign_in/sign_in_page.dart';
import '../../features/sign_up/signup_page.dart';
import '../../presentation/pages/change_password_page.dart';
import '../../presentation/pages/home_page.dart';
import '../../presentation/pages/page_not_found.dart';
import '../../presentation/pages/password_reset_page.dart';
import '../../presentation/pages/splash_page.dart';
import '../../presentation/pages/verify_email_page.dart';
import '../../presentation/widgets/app_scaffold.dart';
import 'page_transition.dart';
import 'router_redirect_service.dart';
import 'router_refresh_bloc.dart' show GoRouterRefreshBloc;

part 'route_names.dart';
part 'router.dart';
