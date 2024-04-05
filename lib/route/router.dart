import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_v7_practices/screen/10_transition_screen_1.dart';
import 'package:go_router_v7_practices/screen/10_transition_screen_2.dart';
import 'package:go_router_v7_practices/screen/11_error_screen.dart';
import 'package:go_router_v7_practices/screen/1_basic_screen.dart';
import 'package:go_router_v7_practices/screen/2_named_screen.dart';
import 'package:go_router_v7_practices/screen/3_push_screen.dart';
import 'package:go_router_v7_practices/screen/4_pop_base_screen.dart';
import 'package:go_router_v7_practices/screen/5_pop_return_screen.dart';
import 'package:go_router_v7_practices/screen/6_path_param_screen.dart';
import 'package:go_router_v7_practices/screen/7_query_parameter.dart';
import 'package:go_router_v7_practices/screen/8_nested_child_screen.dart';
import 'package:go_router_v7_practices/screen/8_nested_screen.dart';
import 'package:go_router_v7_practices/screen/9_login_screen.dart';
import 'package:go_router_v7_practices/screen/9_private_screen.dart';
import 'package:go_router_v7_practices/screen/root_screen.dart';

// 로그인이 됐는지 안됐는지
// true - login OK / false - login NO
bool authState = false;

// https://blog.codefactory.ai/ -> / -> path
// https://blog.codefactory.ai/flutter -> /flutter
// / -> home
// /basic -> basic screen
//
// /named

final router = GoRouter(
  redirect: (context, state) {
    // return string (path) -> 해당 라우트로 이동한다 (path)
    // return null -> 원래 이동하려던 라우트로 이동한다.
    if (state.location == '/login/private' && !authState) {
      return '/login';
    }
    return null;
  },
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {
        return RootScreen();
      },
      routes: [
        GoRoute(
          path: 'basic',
          builder: (context, state) {
            return BasicScreen();
          },
        ),
        GoRoute(
          path: 'named',
          name: 'named_screen',
          builder: (context, state) {
            return NamedScreen();
          },
        ),
        GoRoute(
          path: 'push',
          builder: (context, state) {
            return PushScreen();
          },
        ),
        GoRoute(
          path: 'pop',
          builder: (context, state) {
            return PopBaseScreen();
          },
          routes: [
            GoRoute(
              path: 'return',
              builder: (context, state) {
                return PopReturnScreen();
              },
            ),
          ],
        ),
        GoRoute(
          path: 'path_param/:id', // /path_param/123
          builder: (context, state) {
            return PathParamScreen();
          },
          routes: [
            GoRoute(
              path: ':name',
              builder: (context, state) {
                return PathParamScreen();
              },
            ),
          ],
        ),
        GoRoute(
          path: 'query_param',
          builder: (context, state) {
            return QueryParameterScreen();
          },
        ),
        ShellRoute(
          builder: (context, state, child) {
            return NestedScreen(child: child);
          },
          routes: [
            GoRoute(
              path: 'nested/a',
              builder: (_, state) => NestedChildScreen(
                routerName: '/nested/a',
              ),
            ),
            GoRoute(
              path: 'nested/b',
              builder: (_, state) => NestedChildScreen(
                routerName: '/nested/b',
              ),
            ),
            GoRoute(
              path: 'nested/c',
              builder: (_, state) => NestedChildScreen(
                routerName: '/nested/c',
              ),
            ),
          ],
        ),
        GoRoute(
          path: 'login',
          builder: (_, state) => LoginScreen(),
          routes: [
            GoRoute(
              path: 'private',
              builder: (_, state) => PrivateScreen(),
            ),
          ],
        ),
        GoRoute(
          path: 'login2',
          builder: (_, state) => LoginScreen(),
          routes: [
            GoRoute(
                path: 'private',
                builder: (_, state) => PrivateScreen(),
                redirect: (context, state) {
                  if (!authState) {
                    return '/login2';
                  }
                  return null;
                }),
          ],
        ),
        GoRoute(
          path: 'transition',
          builder: (_, state) => TransitionScreenOne(),
          routes: [
            GoRoute(
              path: 'detail',
              pageBuilder: (_, state) => CustomTransitionPage(
                transitionDuration: Duration(seconds: 1),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
                child: TransitionScreenTwo(),
              ),
              // builder: (_, state) => TransitionScreenTwo(),
            ),
          ],
        ),
      ],
    ),
  ],

  errorBuilder: (context, state) => ErrorScreen(error: state.error.toString(),),
  debugLogDiagnostics: true,

);
