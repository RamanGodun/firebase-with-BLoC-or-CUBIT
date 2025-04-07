/*
This enum represents the possible states that the Activity fetching process can be in.
It allows tracking whether the app is idle, loading data, has successfully loaded data,
or encountered a failure. This pattern provides a clean way to manage state transitions.
 */
enum ActivityStatus {
  initial,
  loading,
  success,
  failure,
}
