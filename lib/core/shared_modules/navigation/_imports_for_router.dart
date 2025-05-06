import 'package:go_router/go_router.dart';
import '../../app_config/bootstrap/di_container.dart';
import '../../../features/auth/presentation/auth_bloc/auth_bloc.dart';
import '../../../features/profile/presentation/profile_page.dart';
import '../../../features/auth/presentation/sign_in/sign_in_page.dart';
import '../../../features/auth/presentation/sign_up/sign_up_page.dart';
import '../../shared_presentation/shared_pages/change_password_page.dart';
import '../../shared_presentation/shared_pages/_home_page.dart';
import '../../shared_presentation/shared_pages/page_not_found.dart';
import '../../shared_presentation/shared_pages/password_reset_page.dart';
import '../../shared_presentation/shared_pages/splash_page.dart';
import '../../shared_presentation/shared_pages/verify_email_page.dart';
import 'widgets/app_scaffold.dart';
import 'utils/page_transition.dart';
import 'utils/router_redirect.dart';
import 'utils/router_refresher.dart' show GoRouterRefresher;

part 'routes_names.dart';
part 'router.dart';
