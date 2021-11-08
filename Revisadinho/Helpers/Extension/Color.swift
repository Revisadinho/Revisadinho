//
//  Color.swift
//  Revisadinho
//
//  Created by Jhennyfer Rodrigues de Oliveira on 14/09/21.
//

import Foundation
import UIKit

extension UIColor {
    // appBackgroundColor - blueBackground
    static let blueBackground: UIColor = {
       if #available(iOS 13, *) {
           return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
               if UITraitCollection.userInterfaceStyle == .dark {
                   // Return the color for Dark Mode
                   // 6, 13, 16
                   return UIColor(red: 18/255, green: 16/255, blue: 28/255, alpha: 1)
//                   return UIColor(red: 46/255, green: 44/255, blue: 54/255, alpha: 1)
               } else {
                   // Return the color for Light Mode
                   return UIColor(red: 249/255, green: 251/255, blue: 252/255, alpha: 1)
               }
           }
       } else {
           // Return a fallback color for iOS 12 and lower.
           return UIColor(red: 249/255, green: 251/255, blue: 252/255, alpha: 1)
       }
   }()

    static let monthCardBackground: UIColor = {
       if #available(iOS 13, *) {
           return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
               if UITraitCollection.userInterfaceStyle == .dark {
                   // Return the color for Dark Mode
//                   return UIColor(red: 72/255, green: 70/255, blue: 93/255, alpha: 1)
//                   return UIColor(red: 52/255, green: 50/255, blue: 63/255, alpha: 1)
                   return UIColor(red: 26/255, green: 23/255, blue: 39/255, alpha: 1)
               } else {
                   // Return the color for Light Mode
                   return .white
               }
           }
       } else {
           return .white
       }
   }()

    // actionColor - purpleAction
    static let purpleAction: UIColor = {
        if #available(iOS 13, *) {
            return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
                if UITraitCollection.userInterfaceStyle == .dark {
                    // Return the color for Dark Mode
                    // 6, 13, 16
//                    return UIColor(red: 197/255, green: 180/255, blue: 253/255, alpha: 1)
                    return UIColor(red: 150/255, green: 121/255, blue: 247/255, alpha: 1)
                } else {
                    // Return the color for Light Mode
                    return UIColor(red: 150/255, green: 121/255, blue: 247/255, alpha: 1)
                }
            }
        } else {
            // Return a fallback color for iOS 12 and lower.
            return UIColor(red: 150/255, green: 121/255, blue: 247/255, alpha: 1)
        }
    }()

    static let blueTabBar: UIColor = {
        if #available(iOS 13, *) {
            return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
                if UITraitCollection.userInterfaceStyle == .dark {
                    // Return the color for Dark Mode
                    return UIColor(red: 249/255, green: 251/255, blue: 252/255, alpha: 1)
                } else {
                    // Return the color for Light Mode
                    return UIColor(red: 41/255, green: 48/255, blue: 98/255, alpha: 1)
                }
            }
        } else {
            return UIColor(red: 41/255, green: 48/255, blue: 98/255, alpha: 1)
        }
    }()

    static let tabBarColor: UIColor = {
        if #available(iOS 13, *) {
            return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
                if UITraitCollection.userInterfaceStyle == .dark {
                    // Return the color for Dark Mode
                    return UIColor(red: 26/255, green: 23/255, blue: 39/255, alpha: 1)
                } else {
                    // Return the color for Light Mode
                    return UIColor(red: 41/255, green: 48/255, blue: 98/255, alpha: 1)
                }
            }
        } else {
            return UIColor(red: 41/255, green: 48/255, blue: 98/255, alpha: 1)
        }
    }()

    static let grayText: UIColor = {
        if #available(iOS 13, *) {
            return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
                if UITraitCollection.userInterfaceStyle == .dark {
                    // Return the color for Dark Mode
                    return UIColor(red: 249/255, green: 251/255, blue: 252/255, alpha: 1)
                } else {
                    // Return the color for Light Mode
                    return UIColor(red: 61/255, green: 60/255, blue: 80/255, alpha: 1)
                }
            }
        } else {
            return UIColor(red: 61/255, green: 60/255, blue: 80/255, alpha: 1)
        }
    }()

    static let buttonLabelText: UIColor = {
        if #available(iOS 13, *) {
            return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
                if UITraitCollection.userInterfaceStyle == .dark {
                    // Return the color for Dark Mode
//                    return UIColor(red: 61/255, green: 60/255, blue: 80/255, alpha: 1)
                    return UIColor(red: 249/255, green: 251/255, blue: 252/255, alpha: 1)
                } else {
                    // Return the color for Light Mode
                    return UIColor(red: 249/255, green: 251/255, blue: 252/255, alpha: 1)
                }
            }
        } else {
            return UIColor(red: 249/255, green: 251/255, blue: 252/255, alpha: 1)
        }
    }()

    static let purpleTabBarItem: UIColor = {
        if #available(iOS 13, *) {
            return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
                if UITraitCollection.userInterfaceStyle == .dark {
                    // Return the color for Dark Mode
                    return UIColor(red: 249/255, green: 251/255, blue: 252/255, alpha: 1)
                } else {
                    // Return the color for Light Mode
                    return UIColor(red: 215/255, green: 219/255, blue: 249/255, alpha: 1)
                }
            }
        } else {
            return UIColor(red: 215/255, green: 219/255, blue: 249/255, alpha: 1)
        }
    }()

    static let purpleSelectedItemTabBar: UIColor = {
        if #available(iOS 13, *) {
            return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
                if UITraitCollection.userInterfaceStyle == .dark {
                    // Return the color for Dark Mode
                    return UIColor(red: 6/255, green: 13/255, blue: 16/255, alpha: 1)
                } else {
                    // Return the color for Light Mode
                    return UIColor(red: 215/255, green: 219/255, blue: 249/255, alpha: 1)
                }
            }
        } else {
            return UIColor(red: 215/255, green: 219/255, blue: 249/255, alpha: 1)
        }
    }()

    static let purpleNoSelectedItemTabBar: UIColor = {
        if #available(iOS 13, *) {
            return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
                if UITraitCollection.userInterfaceStyle == .dark {
                    // Return the color for Dark Mode
                    return UIColor(red: 138/255, green: 142/255, blue: 176/255, alpha: 1)
                } else {
                    // Return the color for Light Mode
                    return UIColor(red: 138/255, green: 142/255, blue: 176/255, alpha: 1)
                }
            }
        } else {
            return UIColor(red: 138/255, green: 142/255, blue: 176/255, alpha: 1)
        }
    }()

    static let grayPlaceholderText: UIColor = {
        if #available(iOS 13, *) {
            return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
                if UITraitCollection.userInterfaceStyle == .dark {
                    // Return the color for Dark Mode
                    return UIColor(red: 196/255, green: 196/255, blue: 199/255, alpha: 1)
                } else {
                    // Return the color for Light Mode
                    return UIColor(red: 140/255, green: 140/255, blue: 140/255, alpha: 1)
                }
            }
        } else {
            return UIColor(red: 140/255, green: 140/255, blue: 140/255, alpha: 1)
        }
    }()

    static let purpleDayNameCalendar: UIColor = {
        if #available(iOS 13, *) {
            return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
                if UITraitCollection.userInterfaceStyle == .dark {
                    // Return the color for Dark Mode
                    return UIColor(red: 172/255, green: 172/255, blue: 179/255, alpha: 1)
                } else {
                    // Return the color for Light Mode
                    return UIColor(red: 138/255, green: 142/255, blue: 176/255, alpha: 1)
                }
            }
        } else {
            return UIColor(red: 138/255, green: 142/255, blue: 176/255, alpha: 1)
        }
    }()

    static let selecCalendar: UIColor = {
        if #available(iOS 13, *) {
            return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
                if UITraitCollection.userInterfaceStyle == .dark {
                    // Return the color for Dark Mode
                    return UIColor(red: 172/255, green: 172/255, blue: 179/255, alpha: 1)
                } else {
                    // Return the color for Light Mode
                    return UIColor(red: 138/255, green: 142/255, blue: 176/255, alpha: 1)
                }
            }
        } else {
            return UIColor(red: 138/255, green: 142/255, blue: 176/255, alpha: 1)
        }
    }()

    static let iconsBorderColor: UIColor = {
        if #available(iOS 13, *) {
            return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
                if UITraitCollection.userInterfaceStyle == .dark {
                    // Return the color for Dark Mode
                    return UIColor(red: 104/255, green: 101/255, blue: 134/255, alpha: 1)
//                    return UIColor(red: 46/255, green: 43/255, blue: 60/255, alpha: 1)
                } else {
                    // Return the color for Light Mode
                    return UIColor(displayP3Red: 232/255, green: 234/255, blue: 255/255, alpha: 1)
                }
            }
        } else {
            return UIColor(displayP3Red: 232/255, green: 234/255, blue: 255/255, alpha: 1)
        }
    }()

    static let calenderDaysColor: UIColor = {
        if #available(iOS 13, *) {
            return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
                if UITraitCollection.userInterfaceStyle == .dark {
                    // Return the color for Dark Mode
                    return UIColor(red: 249/255, green: 251/255, blue: 252/255, alpha: 1)
                } else {
                    // Return the color for Light Mode
                    return .black
                }
            }
        } else {
            return .black
        }
    }()

    static let calenderDaysOutColor: UIColor = {
        if #available(iOS 13, *) {
            return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
                if UITraitCollection.userInterfaceStyle == .dark {
                    // Return the color for Dark Mode
                    return .darkGray
                } else {
                    // Return the color for Light Mode
                    return .lightGray
                }
            }
        } else {
            return .lightGray
        }
    }()

    static var inactiveColor: UIColor = {
        return .gray
    }()

    static let borderServiceItem: UIColor = {
        if #available(iOS 13, *) {
            return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
                if UITraitCollection.userInterfaceStyle == .dark {
                    // Return the color for Dark Mode
                    return UIColor(red: 46/255, green: 43/255, blue: 60/255, alpha: 1)
                } else {
                    // Return the color for Light Mode
                    return UIColor(red: 215/255, green: 219/255, blue: 249/255, alpha: 1)
                }
            }
        } else {
            return UIColor(red: 215/255, green: 219/255, blue: 249/255, alpha: 1)
        }
    }()

    static let sectionMarkerView: UIColor = {
        if #available(iOS 13, *) {
            return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
                if UITraitCollection.userInterfaceStyle == .dark {
                    // Return the color for Dark Mode
                    return UIColor(red: 104/255, green: 101/255, blue: 134/255, alpha: 1)
                } else {
                    // Return the color for Light Mode
                    return UIColor(displayP3Red: 232/255, green: 234/255, blue: 255/255, alpha: 1)
                }
            }
        } else {
            return UIColor(displayP3Red: 232/255, green: 234/255, blue: 255/255, alpha: 1)
        }
    }()

}

// extension UIColor {
//    static var appBackgroundColor: UIColor = {
//        return UIColor(displayP3Red: 249/255, green: 251/255, blue: 252/255, alpha: 1)
//    }()
//
//    static var actionColor: UIColor = {
//        return UIColor(displayP3Red: 150/255, green: 121/255, blue: 247/255, alpha: 1)
//    }()
//
//    static var inactiveColor: UIColor = {
//        return .gray
//    }()
//
//    static var mainColor: UIColor = {
//       return UIColor(displayP3Red: 61/255, green: 60/255, blue: 80/255, alpha: 1)
//    }()
//
// //    static var iconsBorderColor: UIColor = {
// //        return UIColor(displayP3Red: 232/255, green: 234/255, blue: 255/255, alpha: 1)
// //    }()
//
//    static var secondColor: UIColor = {
//        return UIColor(displayP3Red: 138/255, green: 142/255, blue: 176/255, alpha: 1)
//    }()
// }
