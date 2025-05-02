import 'package:go_router/go_router.dart';
import '../di/di_container.dart';
import '../../features/presentation/auth_bloc/auth_bloc.dart';
import '../../features/presentation/profile/profile_page.dart';
import '../../features/presentation/sign_in/sign_in_page.dart';
import '../../features/presentation/sign_up/signup_page.dart';
import '../../presentation_common/pages/change_password_page.dart';
import '../../presentation_common/pages/_home_page.dart';
import '../../presentation_common/pages/page_not_found.dart';
import '../../presentation_common/pages/password_reset_page.dart';
import '../../presentation_common/pages/splash_page.dart';
import '../../presentation_common/pages/verify_email_page.dart';
import '../../presentation_common/widgets/app_scaffold.dart';
import 'utils/page_transition.dart';
import 'utils/router_redirect.dart';
import 'utils/router_refresher.dart' show GoRouterRefresher;

part 'routes_names.dart';
part 'router.dart';
