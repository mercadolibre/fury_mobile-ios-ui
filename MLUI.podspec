Pod::Spec.new do |s|
  s.name             = "MLUI"
  s.version          = "5.26.3"
  s.summary          = "MercadoLibre mobile ios UI components"
  s.homepage         = "https://github.com/mercadolibre"
  s.license          = "Apache License, Version 2.0"
  s.author           = { "mobile arquitectura @ meli" => "mobile-arquitectura@mercadolibre.com" }
  s.source           = { :git => "https://github.com/mercadolibre/fury_mobile-ios-ui.git", :tag => s.version }
  s.platform         = :ios, '13.0'
  s.requires_arc     = true
  s.deprecated = true
  s.deprecated_in_favor_of = 'AndesUI'

  s.subspec 'StyleSheet' do |styleSheet|
    styleSheet.source_files = "LibraryComponents/StyleSheet/classes/*.{h,m}"
  end

  s.subspec 'Helpers' do |helpers|
    helpers.source_files = "LibraryComponents/Helpers/classes/*.{h,m}"
  end

  s.subspec 'Core' do |core|
    core.source_files  = "LibraryComponents/Core/classes/*.{h,m,c}"
    core.dependency 'MLUI/MLFonts'
  end

  s.subspec 'ActionButton' do |actionButton|
    actionButton.source_files = "LibraryComponents/ActionButton/classes/*.{h,m}"
    actionButton.dependency 'MLUI/Core'
  end

  s.subspec 'PriceView' do |priceView|
    priceView.source_files = "LibraryComponents/PriceView/classes/*.{h,m}"
    priceView.resources = "LibraryComponents/PriceView/classes/*.xib"
    priceView.dependency 'MLUI/Core'
    priceView.dependency 'MLUI/MLFonts'
  end

  s.subspec 'SnackBarView' do |snackBarView|
    snackBarView.source_files = "LibraryComponents/MLUISnackbar/classes/*.{h,m}"
    snackBarView.resources = "LibraryComponents/MLUISnackbar/classes/*.xib"
    snackBarView.dependency 'MLUI/Helpers'
    snackBarView.dependency 'MLUI/MLFonts'
  end

  s.subspec 'MLTitledSingleLineTextField' do |textField|
      textField.source_files = "LibraryComponents/MLTitledSingleLineTextField/classes/*.{h,m}"
      textField.resources = "LibraryComponents/MLTitledSingleLineTextField/assets/*"
      textField.dependency 'MLUI/MLColorPalette'
      textField.dependency 'MLUI/MLFonts'
      textField.dependency 'MLUI/StyleSheet'
  end

  s.subspec 'MLTitledMultiLineTextField' do |textField|
      textField.source_files = "LibraryComponents/MLTitledMultiLineTextField/classes/*.{h,m}"
      textField.dependency 'MLUI/MLColorPalette'
      textField.dependency 'MLUI/MLFonts'
      textField.dependency 'MLUI/MLTitledSingleLineTextField'
      textField.dependency 'MLUI/StyleSheet'
  end

  s.subspec 'MLColorPalette' do |mlcolorpalette|
    mlcolorpalette.source_files = "LibraryComponents/MLColorPalette/classes/*.{h,m}"
  end

  s.subspec 'MLFonts' do |mlfonts|
      mlfonts.source_files = "LibraryComponents/MLFonts/classes/*.{h,m}"
      mlfonts.dependency 'JRSwizzle', '1.0'
      mlfonts.dependency 'MLUI/Helpers'
      mlfonts.dependency 'MLUI/StyleSheet'
  end

  s.subspec 'MLFullscreenModal' do |mlfullmodal|
    mlfullmodal.source_files = "LibraryComponents/MLFullscreenModal/classes/*.{h,m}"
    mlfullmodal.resources = "LibraryComponents/MLFullscreenModal/classes/*.xib","LibraryComponents/MLFullscreenModal/assets/*"
    mlfullmodal.dependency 'MLUI/MLColorPalette'
    mlfullmodal.dependency 'MLUI/MLFonts'
    mlfullmodal.dependency 'MLUI/MLButton'
    mlfullmodal.dependency 'FXBlurView', '1.6.4'
    mlfullmodal.dependency 'MLUI/Core'
    mlfullmodal.dependency 'MLUI/StyleSheet'
    mlfullmodal.dependency 'MLUI/MLHeader'
  end

  s.subspec 'MLHeader' do |mlheader|
      mlheader.source_files = "LibraryComponents/MLHeader/classes/*.{h,m}"
      mlheader.resources = "LibraryComponents/MLHeader/classes/*.xib"
      mlheader.dependency 'MLUI/StyleSheet'
      mlheader.dependency 'MLUI/MLColorPalette'
  end

  s.subspec 'MLHtml' do |mlhtml|
      mlhtml.source_files = "LibraryComponents/MLHtml/classes/*.{h,m}"
      mlhtml.dependency 'MLUI/MLFonts'
  end

  s.subspec 'MLButton' do |mlbutton|
    mlbutton.source_files = "LibraryComponents/MLButton/classes/*.{h,m}"
    mlbutton.dependency 'MLUI/MLColorPalette'
    mlbutton.dependency 'MLUI/MLFonts'
    mlbutton.dependency 'MLUI/MLSpinner'
    mlbutton.dependency 'MLUI/StyleSheet'
    mlbutton.dependency 'MLUI/Core'
  end

  s.subspec 'MLModal' do |mlmodal|
    mlmodal.source_files = "LibraryComponents/MLModal/classes/*.{h,m}"
    mlmodal.resources = "LibraryComponents/MLModal/classes/*.xib","LibraryComponents/MLModal/assets/*"
    mlmodal.dependency 'MLUI/MLColorPalette'
    mlmodal.dependency 'MLUI/MLFonts'
    mlmodal.dependency 'MLUI/MLButton'
    mlmodal.dependency 'FXBlurView', '1.6.4'
    mlmodal.dependency 'MLUI/Core'
    mlmodal.dependency 'MLUI/StyleSheet'
  end

  s.subspec 'MLSnackBar' do |mlsnackbar|
    mlsnackbar.source_files = "LibraryComponents/MLSnackBar/classes/*.{h,m}"
    mlsnackbar.resources = "LibraryComponents/MLSnackBar/classes/*.xib"
    mlsnackbar.dependency 'MLUI/MLColorPalette'
    mlsnackbar.dependency 'MLUI/MLFonts'
    mlsnackbar.dependency 'MLUI/MLButton'
    mlsnackbar.dependency 'MLUI/Helpers'
  end

  s.subspec 'MLSpinner' do |mlspinner|
    mlspinner.source_files = "LibraryComponents/MLSpinner/classes/*.{h,m}"
    mlspinner.resources = "LibraryComponents/MLSpinner/classes/*.xib"
    mlspinner.dependency 'MLUI/MLColorPalette'
    mlspinner.dependency 'MLUI/MLFonts'
    mlspinner.dependency 'MLUI/StyleSheet'
  end

  s.subspec 'MLContextualMenu' do |mllongpressmenu|
    mllongpressmenu.dependency 'MLUI/MLColorPalette'
    mllongpressmenu.dependency 'MLUI/MLFonts'
    mllongpressmenu.source_files = "LibraryComponents/MLContextualMenu/*.{h,m}"
  end

  s.subspec 'MLRadioButton' do |mlradiobutton|
    mlradiobutton.source_files = ["LibraryComponents/MLBooleanWidget/MLRadioButton/classes/*.{h,m}", "LibraryComponents/MLBooleanWidget/classes/*.{h,m}"]
    mlradiobutton.dependency 'MLUI/StyleSheet'
  end

  s.subspec 'MLCheckBox' do |mlcheckbox|
    mlcheckbox.source_files = ["LibraryComponents/MLBooleanWidget/MLCheckBox/classes/*.{h,m}", "LibraryComponents/MLBooleanWidget/classes/*.{h,m}"]
    mlcheckbox.dependency 'MLUI/MLColorPalette'
    mlcheckbox.dependency 'MLUI/StyleSheet'
  end

  s.subspec 'MLSwitch' do |mlswitch|
    mlswitch.source_files = ["LibraryComponents/MLBooleanWidget/MLSwitch/classes/*.{h,m}", "LibraryComponents/MLBooleanWidget/classes/*.{h,m}"]
    mlswitch.resources = "LibraryComponents/MLBooleanWidget/MLSwitch/classes/*.xib"
    mlswitch.dependency 'MLUI/MLColorPalette'
    mlswitch.dependency 'MLUI/Helpers'
  end

  s.subspec 'MLSpacing' do |mlspacing|
    mlspacing.source_files = "LibraryComponents/MLSpacing/classes/*.{h,m}"
    mlspacing.dependency 'MLUI/MLFonts'
    mlspacing.dependency 'JRSwizzle', '1.0'
  end

  s.subspec 'MLGenericErrorView' do |mlerrorview|
    mlerrorview.source_files = "LibraryComponents/MLGenericErrorView/classes/*.{h,m}"
    mlerrorview.resources = "LibraryComponents/MLGenericErrorView/classes/*.xib"
    mlerrorview.dependency 'MLUI/MLColorPalette'
    mlerrorview.dependency 'MLUI/MLButton'
    mlerrorview.dependency 'MLUI/MLSpacing'
  end

   s.subspec 'MLTextView' do |mltextView|
      mltextView.source_files = "LibraryComponents/MLTextView/classes/*.{h,m}"
      mltextView.resources = "LibraryComponents/MLTextView/assets/*"
      mltextView.dependency 'MLUI/MLColorPalette'
      mltextView.dependency 'MLUI/MLFonts'
  end

end
