import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'
    show ControlsDetails, ControlsWidgetBuilder, Step, StepState, StepperType;

export 'package:flutter/material.dart'
    show Step, ControlsWidgetBuilder, ControlsDetails, StepState, StepperType;

const double _kLineWidth = 1.0;
const double _kStepSize = 44.0;
const double _kStepMargin = 24.0;
const double _kStepPadding = 0.0;
const double _kStepSpacing = 12.0;
const double _kStepFontSize = 20.0;
const double _kTriangleHeight = _kStepSize * 0.866025;
const Duration _kThemeAnimationDuration = Duration(milliseconds: 200);

class CupertinoStepper extends StatefulWidget {
  const CupertinoStepper({
    Key? key,
    required this.steps,
    this.physics,
    this.type = StepperType.vertical,
    this.currentStep = 0,
    this.continueButtonColor,
    this.continueButtonTextColor,
    this.onStepTapped,
    this.onStepContinue,
    this.onStepCancel,
    this.controlsBuilder,
  })  : assert(0 <= currentStep && currentStep < steps.length),
        super(key: key);

  final List<Step> steps;
  final ScrollPhysics? physics;
  final StepperType type;
  final int currentStep;
  final Color? continueButtonColor;
  final Color? continueButtonTextColor;
  final ValueChanged<int>? onStepTapped;
  final VoidCallback? onStepContinue;
  final VoidCallback? onStepCancel;
  final ControlsWidgetBuilder? controlsBuilder;

  @override
  State<CupertinoStepper> createState() => _CupertinoStepperState();
}

class _CupertinoStepperState extends State<CupertinoStepper> {
  late List<GlobalKey> _keys;
  final Map<int, StepState> _oldStates = <int, StepState>{};

  @override
  void initState() {
    super.initState();
    _keys = List<GlobalKey>.generate(
      widget.steps.length,
      (int i) => GlobalKey(),
    );

    for (int i = 0; i < widget.steps.length; i += 1) {
      _oldStates[i] = widget.steps[i].state;
    }
  }

  @override
  void didUpdateWidget(CupertinoStepper oldWidget) {
    super.didUpdateWidget(oldWidget);
    assert(widget.steps.length == oldWidget.steps.length);

    for (int i = 0; i < oldWidget.steps.length; i += 1) {
      _oldStates[i] = oldWidget.steps[i].state;
    }
  }

  bool _isFirst(int index) {
    return index == 0;
  }

  bool _isLast(int index) {
    return widget.steps.length - 1 == index;
  }

  bool _isCurrent(int index) {
    return widget.currentStep == index;
  }

  Widget _buildLine(bool visible) {
    return Container(
      width: visible ? _kLineWidth : 0.0,
      height: 16.0,
      color: CupertinoColors.separator,
    );
  }

  Widget _buildCircleChild(int index, bool oldState) {
    final CupertinoThemeData themeData = CupertinoTheme.of(context);
    final StepState state = oldState ? _oldStates[index]! : widget.steps[index].state;
    final bool isActive = widget.steps[index].isActive;
    switch (state) {
      case StepState.disabled:
      case StepState.indexed:
        return Text(
          '${index + 1}',
          style: TextStyle(
              fontSize: _kStepFontSize,
              color: isActive
                  ? CupertinoDynamicColor.resolve(CupertinoColors.white, context)
                  : state == StepState.disabled
                      ? CupertinoDynamicColor.resolve(CupertinoColors.placeholderText, context)
                      : themeData.primaryColor),
        );
      case StepState.editing:
        return Icon(
          CupertinoIcons.pencil,
          color: isActive
              ? CupertinoDynamicColor.resolve(CupertinoColors.white, context)
              : themeData.primaryColor,
          size: _kStepFontSize,
        );
      case StepState.complete:
        return Icon(
          CupertinoIcons.check_mark,
          color: isActive
              ? CupertinoDynamicColor.resolve(CupertinoColors.white, context)
              : themeData.primaryColor,
          size: _kStepFontSize * 2,
        );
      case StepState.error:
        return const Text('!',
            style: TextStyle(fontSize: _kStepFontSize, color: CupertinoColors.white));
    }
  }

  Color? _circleColor(int index) {
    final CupertinoThemeData themeData = CupertinoTheme.of(context);
    return widget.steps[index].isActive ? themeData.primaryColor : null;
  }

  Color _borderColor(int index) {
    final CupertinoThemeData themeData = CupertinoTheme.of(context);
    return widget.steps[index].state == StepState.disabled
        ? CupertinoDynamicColor.resolve(CupertinoColors.placeholderText, context)
        : themeData.primaryColor;
  }

  Widget _buildCircle(int index, bool oldState) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: _kStepPadding),
      width: _kStepSize,
      height: _kStepSize,
      child: AnimatedContainer(
        curve: Curves.fastOutSlowIn,
        duration: _kThemeAnimationDuration,
        decoration: ShapeDecoration(
          color: _circleColor(index),
          shape: CircleBorder(side: BorderSide(color: _borderColor(index))),
        ),
        child: Center(
          child: _buildCircleChild(index, oldState && widget.steps[index].state == StepState.error),
        ),
      ),
    );
  }

  Widget _buildTriangle(int index, bool oldState) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: _kStepPadding),
      width: _kStepSize,
      height: _kStepSize,
      child: Center(
        child: SizedBox(
          width: _kStepSize,
          height: _kTriangleHeight, // Height of 24dp-long-sided equilateral triangle.
          child: CustomPaint(
            painter: _TrianglePainter(
              color: CupertinoDynamicColor.resolve(CupertinoColors.systemRed, context),
            ),
            child: Align(
              alignment: const Alignment(0.0, 0.8), // 0.8 looks better than the geometrical 0.33.
              child: _buildCircleChild(
                  index, oldState && widget.steps[index].state != StepState.error),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIcon(int index) {
    if (widget.steps[index].state != _oldStates[index]) {
      return AnimatedCrossFade(
        firstChild: _buildCircle(index, true),
        secondChild: _buildTriangle(index, true),
        firstCurve: const Interval(0.0, 0.6, curve: Curves.fastOutSlowIn),
        secondCurve: const Interval(0.4, 1.0, curve: Curves.fastOutSlowIn),
        sizeCurve: Curves.fastOutSlowIn,
        crossFadeState: widget.steps[index].state == StepState.error
            ? CrossFadeState.showSecond
            : CrossFadeState.showFirst,
        duration: _kThemeAnimationDuration,
      );
    } else {
      if (widget.steps[index].state != StepState.error) {
        return _buildCircle(index, false);
      } else {
        return _buildTriangle(index, false);
      }
    }
  }

  Widget _buildVerticalControls() {
    if (widget.controlsBuilder != null) {
      return widget.controlsBuilder!(
        context,
        ControlsDetails(
          currentStep: 0,
          stepIndex: 0,
          onStepContinue: widget.onStepContinue,
          onStepCancel: widget.onStepCancel,
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 90.0, vertical: 25.0),
      child: widget.currentStep == widget.steps.length - 1
          ? CupertinoButton(
              padding: const EdgeInsets.all(3),
              onPressed: widget.onStepCancel,
              borderRadius: BorderRadius.circular(50),
              color: widget.continueButtonColor!,
              child: IntrinsicWidth(
                child: CupertinoDialogAction(
                  isDefaultAction: true,
                  onPressed: widget.onStepCancel,
                  child: Text(
                    'Continue',
                    style: TextStyle(
                      color: widget.continueButtonTextColor!,
                    ),
                  ),
                ),
              ),
            )
          : CupertinoButton(
              padding: const EdgeInsets.all(3),
              onPressed: widget.onStepContinue,
              borderRadius: BorderRadius.circular(50),
              color: widget.continueButtonColor!,
              child: IntrinsicWidth(
                child: CupertinoDialogAction(
                  isDefaultAction: true,
                  onPressed: widget.onStepContinue,
                  child: Text(
                    'Next',
                    style: TextStyle(
                      color: widget.continueButtonTextColor!,
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  TextStyle _titleStyle(int index) {
    final CupertinoThemeData themeData = CupertinoTheme.of(context);
    final CupertinoTextThemeData textTheme = themeData.textTheme;

    switch (widget.steps[index].state) {
      case StepState.indexed:
      case StepState.editing:
      case StepState.complete:
        return textTheme.navActionTextStyle;
      case StepState.disabled:
        return textTheme.navActionTextStyle.copyWith(
            color: CupertinoDynamicColor.resolve(CupertinoColors.placeholderText, context));
      case StepState.error:
        return textTheme.navActionTextStyle
            .copyWith(color: CupertinoDynamicColor.resolve(CupertinoColors.systemRed, context));
    }
  }

  TextStyle _subtitleStyle(int index) {
    final CupertinoThemeData themeData = CupertinoTheme.of(context);
    final CupertinoTextThemeData textTheme = themeData.textTheme;

    switch (widget.steps[index].state) {
      case StepState.indexed:
      case StepState.editing:
      case StepState.complete:
        return textTheme.tabLabelTextStyle;
      case StepState.disabled:
        return textTheme.tabLabelTextStyle.copyWith(
            color: CupertinoDynamicColor.resolve(CupertinoColors.placeholderText, context));
      case StepState.error:
        return textTheme.tabLabelTextStyle
            .copyWith(color: CupertinoDynamicColor.resolve(CupertinoColors.systemRed, context));
    }
  }

  Widget _buildHeaderText(int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        AnimatedDefaultTextStyle(
          style: _titleStyle(index),
          duration: _kThemeAnimationDuration,
          curve: Curves.fastOutSlowIn,
          child: widget.steps[index].title,
        ),
        if (widget.steps[index].subtitle != null)
          Container(
            margin: const EdgeInsets.only(top: 2.0),
            child: AnimatedDefaultTextStyle(
              style: _subtitleStyle(index),
              duration: _kThemeAnimationDuration,
              curve: Curves.fastOutSlowIn,
              child: widget.steps[index].subtitle!,
            ),
          ),
      ],
    );
  }

  Widget _buildVerticalHeader(int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: _kStepMargin),
      child: Row(
        children: <Widget>[
          _buildIcon(index),
          Container(
            margin: const EdgeInsetsDirectional.only(start: _kStepSpacing),
            child: _buildHeaderText(index),
          ),
        ],
      ),
    );
  }

  Widget _buildVerticalBody(int index) {
    return Stack(
      children: <Widget>[
        PositionedDirectional(
          start: _kStepMargin,
          top: 0.0,
          bottom: 0.0,
          child: SizedBox(
            width: _kStepSize,
            child: Center(
              child: SizedBox(
                width: _isLast(index) ? 0.0 : _kLineWidth,
                child: Container(
                  color: CupertinoColors.separator,
                ),
              ),
            ),
          ),
        ),
        AnimatedCrossFade(
          firstChild: Container(height: 0.0),
          secondChild: Container(
            margin: const EdgeInsetsDirectional.only(
              start: 2 * _kStepMargin + _kStepSize,
              end: _kStepMargin,
              bottom: _kStepMargin,
            ),
            child: Column(
              children: <Widget>[
                widget.steps[index].content,
                _buildVerticalControls(),
              ],
            ),
          ),
          firstCurve: const Interval(0.0, 0.6, curve: Curves.fastOutSlowIn),
          secondCurve: const Interval(0.4, 1.0, curve: Curves.fastOutSlowIn),
          sizeCurve: Curves.fastOutSlowIn,
          crossFadeState: _isCurrent(index) ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          duration: _kThemeAnimationDuration,
        ),
      ],
    );
  }

  Widget _buildVertical() {
    return ListView(
      shrinkWrap: true,
      physics: widget.physics,
      children: <Widget>[
        for (int i = 0; i < widget.steps.length; i += 1)
          Column(
            key: _keys[i],
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsetsDirectional.only(
                    start: _kStepMargin + (_kStepSize - _kLineWidth) / 2),
                child: _buildLine(!_isFirst(i)),
              ),
              Focus(
                canRequestFocus: widget.steps[i].state != StepState.disabled,
                child: CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: widget.steps[i].state != StepState.disabled
                      ? () {
                          // In the vertical case we need to scroll to the newly tapped
                          // step.
                          Scrollable.ensureVisible(
                            _keys[i].currentContext!,
                            curve: Curves.fastOutSlowIn,
                            duration: _kThemeAnimationDuration,
                          );

                          if (widget.onStepTapped != null) {
                            widget.onStepTapped!(i);
                          }
                        }
                      : null,
                  child: _buildVerticalHeader(i),
                ),
              ),
              _buildVerticalBody(i),
              Padding(
                padding: const EdgeInsetsDirectional.only(
                    start: _kStepMargin + (_kStepSize - _kLineWidth) / 2),
                child: _buildLine(!_isLast(i)),
              ),
            ],
          ),
      ],
    );
  }

  Widget _buildHorizontal() {
    final List<Widget> children = <Widget>[
      for (int i = 0; i < widget.steps.length; i += 1) ...<Widget>[
        Focus(
          canRequestFocus: widget.steps[i].state != StepState.disabled,
          child: CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: widget.steps[i].state != StepState.disabled
                ? () {
                    if (widget.onStepTapped != null) widget.onStepTapped!(i);
                  }
                : null,
            child: Row(
              children: <Widget>[
                SizedBox(
                  height: 72.0,
                  child: Center(
                    child: _buildIcon(i),
                  ),
                ),
                Container(
                  margin: const EdgeInsetsDirectional.only(start: _kStepSpacing),
                  child: _buildHeaderText(i),
                ),
              ],
            ),
          ),
        ),
        if (!_isLast(i))
          Container(
            margin: const EdgeInsets.symmetric(horizontal: _kStepPadding),
            height: _kLineWidth,
            color: CupertinoColors.separator,
          ),
      ],
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height * 0.1,
          margin: const EdgeInsets.symmetric(horizontal: _kStepMargin),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: children,
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.8,
          child: ListView(
            padding: const EdgeInsets.all(_kStepMargin),
            children: <Widget>[
              AnimatedSize(
                curve: Curves.fastOutSlowIn,
                duration: _kThemeAnimationDuration,
                child: widget.steps[widget.currentStep].content,
              ),
              _buildVerticalControls(),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasDirectionality(context));
    assert(() {
      if (context.findAncestorWidgetOfExactType<CupertinoStepper>() != null) {
        throw FlutterError('Steppers must not be nested.\n'
            'The material specification advises that one should avoid embedding '
            'steppers within steppers. '
            'https://material.io/archive/guidelines/components/steppers.html#steppers-usage');
      }
      return true;
    }());
    switch (widget.type) {
      case StepperType.vertical:
        return _buildVertical();
      case StepperType.horizontal:
        return _buildHorizontal();
    }
  }
}

class _TrianglePainter extends CustomPainter {
  _TrianglePainter({
    required this.color,
  });

  final Color color;

  @override
  bool hitTest(Offset point) => true; // Hitting the rectangle is fine enough.

  @override
  bool shouldRepaint(_TrianglePainter oldPainter) {
    return oldPainter.color != color;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final double base = size.width;
    final double halfBase = size.width / 2.0;
    final double height = size.height;
    final List<Offset> points = <Offset>[
      Offset(0.0, height),
      Offset(base, height),
      Offset(halfBase, 0.0),
    ];

    canvas.drawPath(
      Path()..addPolygon(points, true),
      Paint()..color = color,
    );
  }
}
