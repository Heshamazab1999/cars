part of 'settings_cubit.dart';

@immutable
abstract class SettingsState {}

class SettingsInitial extends SettingsState {}

class ContactUsSuccessState extends SettingsState {}

class ContactUsLoadingState extends SettingsState {}

class ContactUsErrorState extends SettingsState {}

class AboutUsSuccessState extends SettingsState {}

class AboutUsLoadingState extends SettingsState {}

class AboutUsErrorState extends SettingsState {}

class FAQsSuccessState extends SettingsState {}

class FAQsLoadingState extends SettingsState {}

class FAQsErrorState extends SettingsState {}
