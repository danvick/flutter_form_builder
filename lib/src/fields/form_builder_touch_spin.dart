import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_touch_spin/flutter_touch_spin.dart';
import 'package:intl/intl.dart';

class FormBuilderTouchSpin extends FormBuilderField<double> {
  /// Value to increment or decrement by
  final double step;

  /// The minimum value the user can select.
  ///
  /// Defaults to 0.0. Must be less than or equal to [max].
  final double min;

  /// The maximum value the user can select.
  ///
  /// Defaults to 1.0. Must be greater than or equal to [min].
  final double max;

  /// Icon for the decrement button
  final Icon subtractIcon;

  /// Icon for the decrement button
  final Icon addIcon;

  /// Icon sizes for the decrement and increment buttons
  final double iconSize;

  /// NumberFormat to be used when displaying values
  final NumberFormat displayFormat;

  /// Spacing around the decrement and increment icons
  final EdgeInsets iconPadding;

  /// Text styling for the current value of the control
  final TextStyle textStyle;

  /// Color of icon while the widget is in active state
  final Color iconActiveColor;

  /// Color of icon while the widget is in active state
  final Color iconDisabledColor;

  FormBuilderTouchSpin({
    Key key,
    //From Super
    @required String name,
    FormFieldValidator validator,
    @required double initialValue,
    bool readOnly = false,
    InputDecoration decoration = const InputDecoration(),
    ValueChanged<double> onChanged,
    ValueTransformer<double> valueTransformer,
    bool enabled = true,
    FormFieldSetter<double> onSaved,
    AutovalidateMode autovalidateMode = AutovalidateMode.disabled,
    VoidCallback onReset,
    FocusNode focusNode,
    this.step,
    this.min = 1,
    this.max = 9999,
    this.iconSize = 24.0,
    this.displayFormat,
    this.subtractIcon = const Icon(Icons.remove),
    this.addIcon = const Icon(Icons.add),
    this.iconPadding = const EdgeInsets.all(4.0),
    this.textStyle = const TextStyle(fontSize: 24),
    this.iconActiveColor,
    this.iconDisabledColor,
  }) : super(
          key: key,
          initialValue: initialValue,
          name: name,
          validator: validator,
          valueTransformer: valueTransformer,
          onChanged: onChanged,
          readOnly: readOnly,
          autovalidateMode: autovalidateMode,
          onSaved: onSaved,
          enabled: enabled,
          onReset: onReset,
          decoration: decoration,
          focusNode: focusNode,
          builder: (FormFieldState<double> field) {
            final _FormBuilderTouchSpinState state = field;
            final theme = Theme.of(state.context);

            return InputDecorator(
              decoration: decoration.copyWith(
                enabled: !state.readOnly,
                errorText: decoration?.errorText ?? field.errorText,
              ),
              child: TouchSpin(
                key: ObjectKey(state.value),
                min: min,
                max: max,
                step: step,
                value: field.value,
                iconSize: iconSize,
                onChanged: state.readOnly
                    ? null
                    : (value) {
                        state.requestFocus();
                        state.didChange(value);
                      },
                displayFormat: displayFormat,
                textStyle: textStyle,
                addIcon: addIcon,
                subtractIcon: subtractIcon,
                iconActiveColor: iconActiveColor ?? theme.primaryColor,
                iconDisabledColor: iconDisabledColor ?? theme.disabledColor,
                iconPadding: iconPadding,
                enabled: !state.readOnly,
              ),
            );
          },
        );

  @override
  _FormBuilderTouchSpinState createState() => _FormBuilderTouchSpinState();
}

class _FormBuilderTouchSpinState extends FormBuilderFieldState<double> {
  @override
  FormBuilderTouchSpin get widget => super.widget as FormBuilderTouchSpin;
}
