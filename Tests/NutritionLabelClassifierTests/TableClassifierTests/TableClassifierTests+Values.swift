import XCTest

@testable import NutritionLabelClassifier

let valueExpectations: [String: [[[Value?]]]?] = [

//    "C19F126E-6D6E-464A-B7C4-718AA4384CC2": [
//        [
//            [v(460, .kj),   v(2218, .kj)],
//            [v(6, .g),      v(28, .g)],
//            [v(2.5, .g),    v(13, .g)],
//            [v(0, .g),      v(0, .g)],
//            [v(0, .g),      v(2, .g)],
//            [v(13, .g),     v(66, .g)],
//            [v(3, .g),      v(15, .g)],
//            [v(1, .g),      v(5, .g)],
//            [v(130, .mg),   v(650, .mg)]
//        ]
//    ],
//
//    "DE476A74-8174-4E9C-81DA-450F578F039D": [
//        [
//            [v(735, .kj), v(412, .kj)],
//            [v(13, .g), v(7.3, .g)],
//            [v(3.2, .g), v(1.8, .g)],
//            [v(0.9, .g), v(0.5, .g)],
//            [v(0, .g), v(0, .g)],
//            [v(14, .g), v(7.8, .g)]
//        ]
//    ],
//
//    "B1E5C59E-7B94-4570-B226-DD9D17BC743E" : [
//        [
//            [v(1239, .kj), v(992, .kj)],
//            [v(11, .g), v(9, .g)],
//            [v(7.7, .g), v(6.2, .g)],
//            [v(43, .g), v(34, .g)],
//            [v(25, .g), v(20, .g)],
//            [v(2.2, .g), v(1.8, .g)],
//            [v(4.9, .g), v(3.9, .g)],
//            [v(0.81, .g), v(0.65, .g)]
//        ]
//    ],
//
//    "75C66881-51E5-4A42-92E6-F3B3953BC8E6": [
//        [
//            [v(1387, .kj), v(277, .kj)],
//            [v(35.1, .g), v(7, .g)],
//            [v(22, .g), v(4.4, .g)],
//            [v(8.6, .g), v(1.7, .g)],
//            [v(0.7, .g), v(0.1, .g)],
//            [v(1.2, .g), v(0.2, .g)],
//            [v(121, .mg), v(24, .mg)],
//            [v(3.3, .g), v(0.7, .g)],
//            [v(3.3, .g), v(0.7, .g)],
//            [v(0, .g), v(0, .g)],
//            [v(2.1, .g), v(0.4, .g)],
//            [v(0.07, .g), v(0.01, .g)],
//            [v(30, .mg), v(6, .mg)]
//        ]
//    ],
//    "9C26D1D5-50B2-4933-B906-29824617FD96": [
//        [
//            [v(1387, .kj), v(277, .kj)],
//            [v(35.1, .g), v(7, .g)],
//            [v(22, .g), v(4.4, .g)],
//            [v(8.6, .g), v(1.7, .g)],
//            [v(0.7, .g), v(0.1, .g)],
//            [v(1.2, .g), v(0.2, .g)],
//            [v(121, .mg), v(24, .mg)],
//            [v(3.3, .g), v(0.7, .g)],
//            [v(3.3, .g), v(0.7, .g)],
//            [v(0, .g), v(0, .g)],
//            [v(2.1, .g), v(0.4, .g)],
//            [v(0.07, .g), v(0.01, .g)],
//            [v(30, .mg), v(6, .mg)]
//        ]
//    ],
//    "1B51A831-FE9C-4752-B526-0ED7823EA591": [
//        [
//            [v(1387, .kj), v(277, .kj)],
//            [v(35.1, .g), v(7, .g)],
//            [v(22, .g), v(4.4, .g)],
//            [v(8.6, .g), v(1.7, .g)],
//            [v(0.7, .g), v(0.1, .g)],
//            [v(1.2, .g), v(0.2, .g)],
//            [v(121, .mg), v(24, .mg)],
//            [v(3.3, .g), v(0.7, .g)],
//            [v(3.3, .g), v(0.7, .g)],
//            [v(0, .g), v(0, .g)],
//            [v(2.1, .g), v(0.4, .g)],
//            [v(0.07, .g), v(0.01, .g)],
//            [v(30, .mg), v(6, .mg)]
//        ]
//    ],
//    "B2C50752-AE52-493A-AD79-69DA4EA74504": [
//        [
//            [v(581, .kj), v(2150, .kj)],
//            [v(2.1, .g), v(7.6, .g)],
//            [v(7.0, .g), v(25.8, .g)],
//            [v(3.4, .g), v(12.5, .g)],
//            [v(16.5, .g), v(61, .g)],
//            [v(0.9, .g), v(3.5, .g)],
//            [v(1, .g), v(3.6, .g)],
//            [v(103, .mg), v(382, .mg)],
//            [v(128, .mg), v(473, .mg)]
//        ]
//    ],
//    "CDD8E0DD-7D2B-4802-9C1D-54EFFBB71E58": [
//        [
//            [v(105, .kcal)],
//            [v(1, .g)],
//            [v(0.6, .g)],
//            [v(0.05, .g)],
//            [v(8, .mg)],
//            [v(66, .mg)],
//            [v(20, .g)],
//            [v(0, .g)],
//            [v(15, .g)],
//            [v(4, .g)],
//            [v(113, .mg)]
//        ]
//    ],
//    "C86F6FD2-ADA2-45C1-818F-AD4A85DC0611": [
//        [
//            [v(1373, .kj), v(351, .kj)],
//            [v(6.8, .g), v(1.71, .g)],
//            [v(75, .g), v(19, .g)],
//            [v(47.3, .g), v(11.8, .g)],
//            [v(0.1, .g), v(0.03, .g)],
//            [v(0.1, .g), v(0.03, .g)],
//            [v(0, .g), v(0, .g)],
//            [v(20, .mg), v(5.03, .mg)],
//        ]
//    ],
//    "81942184-145C-4858-884A-8A76B9BD6498": [
//        [
//            [v(173.0, .kj), v(1150.0, .kj)],
//            [v(0.15, .g), v(1.0, .g)],
//            [v(0.0, .g), v(0.0, .g)],
//            [v(0.15, .g), v(1.0, .g)],
//            [v(0.15, .g), v(1.0, .g)],
//            [v(9.9, .g), v(66.0, .g)],
//            [v(9.8, .g), v(65.0, .g)],
//            [v(0.75, .mg), v(5.0, .mg)],
//        ]
//    ],
//    "8CE7C875-BF15-42A1-A49D-A216D3329C9A": [
//        [
//            [v(1725.0, .kj)],
//            [v(35.0, .g)],
//            [v(22.0, .g)],
//            [v(0.5, .g)],
//            [v(0.5, .g)],
//            [v(25.0, .g)],
//            [v(1.8, .g)],
//        ]
//    ],
//    "413A3118-6D94-4158-8B31-FBC3AAA47FCE": [
//        [
//            [v(264.4, .kcal)],
//            [v(4.8, .g)],
//            [v(29.4, .g)],
//            [v(20.5, .g)],
//            [v(14.2, .g)],
//        ]
//    ],
//    "AC1F7D24-296F-4346-883D-E10890938861": [
//        [
//            [v(1572.0, .kj), v(1006.0, .kj)],
//            [v(17.0, .g), v(11.0, .g)],
//            [v(11.0, .g), v(7.0, .g)],
//            [v(37.0, .g), v(24.0, .g)],
//            [v(3.3, .g), v(2.1, .g)],
//            [v(32.0, .g), v(21.0, .g)],
//            [v(32.0, .g), v(21.0, .g)],
//            [v(0.56, .g), v(0.36, .g)],
//        ]
//    ],
//    "00DC2D0A-2C55-4633-B5AE-DF2BA90C4249": [
//        [
//            [v(2276.0, .kj), v(341.0, .kj)],
//            [v(37.0, .g), v(5.5, .g)],
//            [v(6.5, .g), v(1.0, .g)],
//            [v(51.0, .g), v(7.6, .g)],
//            [v(28.0, .g), v(4.3, .g)],
//            [v(1.1, .g), v(0.2, .g)],
//            [v(3.0, .g), v(0.4, .g)],
//            [v(0.48, .g), v(0.07, .g)],
//        ]
//    ],
//
//    "15D5AD72-033E-4CA4-BA87-D6CB6193EC9B": [
//        [
//            [v(1520.0, .kj), v(532.0, .kj)],
//            [v(12.0, .g), v(4.2, .g)],
//            [v(57.0, .g), v(20.0, .g)],
//            [v(0.7, .g), v(0.25, .g)],
//            [v(9.0, .g), v(3.2, .g)],
//            [v(1.7, .g), v(0.6, .g)],
//            [v(3.4, .g), v(1.2, .g)],
//            [v(3.9, .g), v(1.4, .g)],
//            [v(0.0, .g), v(0.0, .g)],
//            [v(0.0, .mg), v(0.0, .mg)],
//            [v(10.0, .g), v(3.5, .g)],
//            [v(3.0, .g), v(1.1, .g)],
//            [v(7.0, .g), v(2.5, .g)],
//            [v(4.0, .mg), v(1.4, .mg)],
//            [v(148.0, .mg), v(51.8, .mg)],
//            [v(4.2, .mg), v(1.5, .mg)],
//            [v(3.1, .mg), v(1.1, .mg)],
//        ]
//    ],
//    "364EDBD7-004B-4A97-83AA-F6404DE5EEB4": [
//        [
//            [v(379.0, .kj), v(133.0, .kj)],
//            [v(9.0, .g), v(3.2, .g)],
//            [v(1.7, .g), v(0.6, .g)],
//            [v(4.3, .g), v(1.5, .g)],
//            [v(3.0, .g), v(1.1, .g)],
//            [v(67.8, .g), v(23.7, .g)],
//            [v(0.0, .g), v(0.0, .g)],
//            [v(10.0, .g), v(3.5, .g)],
//            [v(4.4, .g), v(1.5, .g)],
//            [v(5.6, .g), v(2.0, .g)],
//            [v(11.6, .g), v(4.1, .g)],
//            [v(7.0, .mg), v(2.5, .mg)],
//            [v(2.4, .mg), v(0.8, .mg)],
//            [v(101.3, .mg), v(35.5, .mg)],
//            [v(2.2, .mg), v(0.8, .mg)],
//        ]
//    ],
//
//    "233BE115-FB25-42CC-BCF5-A2E34CC473B6": [
//        [
//            [v(19.0, .kcal), v(48.0, .kcal)],
//            [v(0.0, .g), v(0.0, .g)],
//            [v(0.0, .g), v(0.0, .g)],
//            [v(4.8, .g), v(12.0, .g)],
//            [v(4.8, .g), v(12.0, .g)],
//            [v(43.0, .mg), v(108.0, .mg)],
//            [v(1.4, .mg), v(3.5, .mg)],
//            [v(0.2, .mg), v(0.5, .mg)],
//            [v(0.3, .mcg), v(0.8, .mcg)],
//        ]
//    ],
//
//    "9D43F6AC-7D3B-498F-AF10-991649E94B74": [
//        [
//            [v(2276.0, .kj), v(341.0, .kj)],
//            [v(37.0, .g), v(5.5, .g)],
//            [v(6.5, .g), v(1.0, .g)],
//            [v(51.0, .g), v(7.6, .g)],
//            [v(28.0, .g), v(4.3, .g)],
//            [v(1.1, .g), v(0.2, .g)],
//            [v(3.0, .g), v(0.4, .g)],
//            [v(0.48, .g), v(0.07, .g)],
//        ]
//    ],
//
//    "32558479-A279-461B-A736-7FE7D14E859A": [
//        [
//            [v(2276.0, .kj), v(341.0, .kj)],
//            [v(37.0, .g), v(5.5, .g)],
//            [v(6.5, .g), v(1.0, .g)],
//            [v(51.0, .g), v(7.6, .g)],
//            [v(28.0, .g), v(4.3, .g)],
//            [v(1.1, .g), v(0.2, .g)],
//            [v(3.0, .g), v(0.4, .g)],
//            [v(0.48, .g), v(0.07, .g)],
//        ]
//    ],
//
//    "C9863E9C-792E-4014-8640-8E1D39EFAC59": [
//        [
//            [v(2276.0, .kj), v(341.0, .kj)],
//            [v(37.0, .g), v(5.5, .g)],
//            [v(6.5, .g), v(1.0, .g)],
//            [v(51.0, .g), v(7.6, .g)],
//            [v(28.0, .g), v(4.3, .g)],
//            [v(1.1, .g), v(0.2, .g)],
//            [v(3.0, .g), v(0.4, .g)],
//            [v(0.48, .g), v(0.07, .g)],
//        ]
//    ],
//
//    "2184C983-5761-4F8F-BE7A-E6771E963FFF": [
//        [
//            [v(422.584, .kj), v(1413, .kj)], /// failed to read in 424 so it's calculated using the ratio
//            [v(0.03, .g), v(0.1, .g)],
//            [v(0.03, .g), v(0.1, .g)],
//            [v(0.0, .g), v(0.0, .g)],
//            [v(0.0, .mg), v(0.8, .mg)],
//            [v(6.0, .mg), v(20.0, .mg)],
//            [v(0.015, .g), v(0.05, .g)],
//            [v(23.4, .g), v(78.0, .g)],
//            [v(0.0, .g), v(0.0, .g)],
//            [v(15.63, .g), v(52.1, .g)],
//            [v(15.63, .g), v(52.1, .g)],
//            [v(2.04, .g), v(6.8, .g)],
//        ]
//    ],
//
//
//    "31D0CA8B-5069-4AB3-B865-47CD1D15D879": [
//        [
//            [v(423.9, .kj), v(1413, .kj)], /// failed to read in 424 so it's calculated using the ratio
//            [v(0.03, .g), v(0.1, .g)],
//            [v(0.03, .g), v(0.1, .g)],
//            [v(0.0, .g), v(0.0, .g)],
//            [v(0.24, .mg), v(0.8, .mg)], /// failed to read 0.0 so 0.24 is calculated using the ratio
//            [v(6.0, .mg), v(20.0, .mg)],
//            [v(0.015, .g), v(0.05, .g)],
//            [v(23.4, .g), v(78.0, .g)],
//            [v(0.0, .g), v(0.0, .g)],
//            [v(15.63, .g), v(52.1, .g)],
//            [v(15.63, .g), v(52.1, .g)],
//            [v(2.04, .g), v(6.8, .g)],
//        ]
//    ],
//
//    "3078556E-1AC2-4DFF-8420-0BAB5597DCAC": [
//        [
//            [v(2276.0, .kj), v(341.0, .kj)],
//            [v(37.0, .g), v(5.5, .g)],
//            [v(6.5, .g), v(1.0, .g)],
//            [v(51.0, .g), v(7.6, .g)],
//            [v(28.0, .g), v(4.3, .g)],
//            [v(1.1, .g), v(0.2, .g)],
//            [v(3.0, .g), v(0.4, .g)],
//            [v(0.48, .g), v(0.07, .g)],
//        ]
//    ],
//
//    "DD0390E1-6555-40C8-9E58-D7B93D731A88": [
//        [
//            [v(0.0, .kcal)],
//            [v(0.0, .g)],
//            [v(0.0, .g)],
//            [v(0.0, .g)],
//            [v(0.2, .mg)],
//        ]
//    ],
//
//    "E84F7C80-50C4-4237-BAAD-BD5C1B958B84": [
//        [
//            [v(264.0, .kj), v(1265.0, .kj)],
//            [v(3.4, .g), v(16.3, .g)],
//            [v(5.3, .g), v(25.4, .g)],
//            [v(3.5, .g), v(17.0, .g)],
//            [v(0.6, .g), v(2.8, .g)],
//            [v(0.6, .g), v(2.8, .g)],
//            [v(275.0, .mg), v(1320.0, .mg)],
//            [v(104.0, .mg), v(500.0, .mg)],
//        ]
//    ],
//
//    "3EDD65E5-6363-42E3-8358-21A520ED21CC": [
//        [
//            [v(1293.0, .kj), v(323.0, .kj)],
//            [v(21.0, .g), v(5.2, .g)],
//            [v(12.0, .g), v(3.0, .g)],
//            [v(2.0, .g), v(0.5, .g)],
//            [v(8.0, .mg), v(2.0, .mg)],
//            [v(5.6, .g), v(1.4, .g)],
//            [v(1.3, .g), v(0.3, .g)],
//            [v(0.0, .g), v(0.0, .g)],
//            [v(24.0, .g), v(6.0, .g)],
//            [v(1.5, .g), v(0.38, .g)],
//            [v(600.0, .mg), v(150.0, .mg)],
//        ]
//    ],
//
//    "3FFEB5C4-610D-488F-BA4B-9BA1E99C020E": [
//        [
//            [v(1293.0, .kj), v(323.0, .kj)],
//            [v(21.0, .g), v(5.2, .g)],
//            [v(12.0, .g), v(3.0, .g)],
//            [v(2.0, .g), v(0.5, .g)],
//            [v(8.0, .mg), v(2.0, .mg)],
//            [v(5.6, .g), v(1.4, .g)],
//            [v(1.3, .g), v(0.3, .g)],
//            [v(0.0, .g), v(0.0, .g)],
//            [v(24.0, .g), v(6.0, .g)],
//            [v(1.5, .g), v(0.38, .g)],
//            [v(600.0, .mg), v(150.0, .mg)],
//        ]
//    ],
//
//    "BE5881E2-44D1-44ED-8471-0DC980A97244": [
//        [
//            [v(1293.0, .kj), v(323.0, .kj)],
//            [v(21.0, .g), v(5.2, .g)],
//            [v(12.0, .g), v(3.0, .g)],
//            [v(2.0, .g), v(0.5, .g)],
//            [v(8.0, .mg), v(2.0, .mg)],
//            [v(5.6, .g), v(1.4, .g)],
//            [v(1.3, .g), v(0.3, .g)],
//            [v(0.0, .g), v(0.0, .g)],
//            [v(24.0, .g), v(6.0, .g)],
//            [v(1.5, .g), v(0.38, .g)],
//            [v(600.0, .mg), v(150.0, .mg)],
//        ]
//    ],
//
//    "26440E08-8A8D-450A-A6DF-6F95C5E76C7D": [
//        [
//            [v(1293.0, .kj), v(323.0, .kj)],
//            [v(21.0, .g), v(5.2, .g)],
//            [v(12.0, .g), v(3.0, .g)],
//            [v(2.0, .g), v(0.5, .g)],
//            [v(8.0, .mg), v(2.0, .mg)],
//            [v(5.6, .g), v(1.4, .g)],
//            [v(1.3, .g), v(0.3, .g)],
//            [v(0.0, .g), v(0.0, .g)],
//            [v(24.0, .g), v(6.0, .g)],
//            [v(1.5, .g), v(0.38, .g)],
//            [v(600.0, .mg), v(150.0, .mg)],
//        ]
//    ],
//
//    "6682E31B-6674-47F7-BF71-CA3B2C7713DC": [
//        [
//            [v(1293.0, .kj), v(323.0, .kj)],
//            [v(21.0, .g), v(5.44, .g)],
//            [v(12.0, .g), v(3.0, .g)],
//            [v(2.0, .g), v(0.5, .g)],
//            [v(8.0, .mg), v(2.0, .mg)],
//            [v(5.6, .g), v(1.4, .g)],
//            [v(1.3, .g), v(0.3, .g)],
//            [v(0.0, .g), v(0.0, .g)],
//            [v(24.0, .g), v(6.0, .g)],
//            [v(1.5, .g), v(0.38, .g)],
//            [v(600.0, .mg), v(150.0, .mg)],
//        ]
//    ],
//
//    "D0A85313-7611-494C-969C-5A2F62A7B9D4": [
//        [
//            [v(1293.0, .kj), v(323.0, .kj)],
//            [v(21.0, .g), v(5.44, .g)],
//            [v(12.0, .g), v(3.0, .g)],
//            [v(2.0, .g), v(0.5, .g)],
//            [v(8.0, .mg), v(2.0, .mg)],
//            [v(5.6, .g), v(1.4, .g)],
//            [v(1.3, .g), v(0.3, .g)],
//            [v(0.0, .g), v(0.0, .g)],
//            [v(24.0, .g), v(6.0, .g)],
//            [v(1.5, .g), v(0.38, .g)],
//            [v(600.0, .mg), v(150.0, .mg)],
//        ]
//    ],
//
//    "7E330674-3589-4B20-BA7A-283FF70AB01C": [
//        [
//            [v(1293.0, .kj), v(323.0, .kj)],
//            [v(21.0, .g), v(5.2, .g)],
//            [v(12.0, .g), v(3.0, .g)],
//            [v(2.0, .g), v(0.5, .g)],
//            [v(8.0, .mg), v(2.0, .mg)],
//            [v(5.6, .g), v(1.4, .g)],
//            [v(1.3, .g), v(0.3, .g)],
//            [v(0.0, .g), v(0.0, .g)],
//            [v(24.0, .g), v(6.0, .g)],
//            [v(1.5, .g), v(0.38, .g)],
//            [v(600.0, .mg), v(150.0, .mg)],
//        ]
//    ],
//
//    "6BAD0EB1-8BED-4DD9-8FD8-C9861A267A3D": [
//        [
//            [v(117.0, .kcal), v(90.0, .kcal)],
//            [v(5.5, .g), v(4.2, .g)],
//            [v(2.0, .g), v(1.5, .g)],
//            [v(1.4, .g), v(1.1, .g)],
//            [v(0.1, .g), v(0.1, .g)],
//            [v(10.0, .mg), v(8.0, .mg)],
//            [v(19.5, .g), v(15.0, .g)],
//            [v(0.7, .g), v(0.5, .g)],
//            [v(72.0, .mg), v(55.0, .mg)],
//            [v(169.0, .mg), v(130.0, .mg)],
//        ]
//    ],
//
//    "991D390B-B741-4821-8DAD-B0F967CE9D3B": [
//        [
//            [v(384.0, .kj), v(284.0, .kj)],
//            [v(2.7, .g), v(2.0, .g)],
//            [v(1.8, .g), v(1.3, .g)],
//            [v(12.1, .g), v(9.0, .g)],
//            [v(10.9, .g), v(8.1, .g)],
//            [v(0.1, .g), v(0.1, .g)],
//            [v(3.7, .g), v(2.7, .g)],
//            [v(0.15, .g), v(0.11, .g)],
//            [v(162.0, .mg), v(120.0, .mg)],
//            [v(3.4, .mcg), v(2.5, .mcg)],
//        ]
//    ],
//
//    "0DEA4407-48DF-4A16-8488-0EB967CB13ED": [
//        [
//            [v(819.0, .kj), v(546.0, .kj)],
//            [v(5.6, .g), v(3.7, .g)],
//            [v(0.0, .mg), v(0.0, .mg)],
//            [v(9.5, .g), v(6.3, .g)],
//            [v(6.2, .g), v(4.1, .g)],
//            [v(21.9, .g), v(14.6, .g)],
//            [v(21.3, .g), v(14.2, .g)],
//            [v(57.0, .mg), v(38.0, .mg)],
//            [v(186.0, .mg), v(124.0, .mg)],
//        ]
//    ],
//
//    "F3B96913-B2CD-4FFB-99B1-B277395BD003": [
//        [
//            [v(864.0, .kj), v(1270.0, .kj)],
//            [v(2.3, .g), v(3.4, .g)],
//            [v(11.2, .g), v(16.4, .g)],
//            [v(6.5, .g), v(9.5, .g)],
//            [v(23.5, .g), v(34.6, .g)],
//            [v(14.6, .g), v(21.4, .g)],
//            [v(128.0, .mg), v(188.0, .mg)],
//        ]
//    ],
//
//    "77B1E2FD-7879-4C75-9CA4-187C3EDAB858": [
//        [
//            [v(475.0, .kj), v(378.0, .kj)],
//            [v(6.3, .g), v(5.0, .g)],
//            [v(2.4, .g), v(1.9, .g)],
//            [v(1.6, .g), v(1.3, .g)],
//            [v(0.1, .g), v(0.1, .g)],
//            [v(8.0, .mg), v(6.0, .mg)],
//            [v(16.6, .g), v(13.3, .g)],
//            [v(0.0, .g), v(0.0, .g)],
//            [v(88.0, .mg), v(70.0, .mg)],
//            [v(200.0, .mg), v(160.0, .mg)],
//        ]
//    ],
//
//    "02CE7C0B-CA9C-4E63-8E42-5D8C105FE320": [
//        [
//            [v(1859.0, .kj), v(279.0, .kj)],
//            [v(0.6, .g), v(0.1, .g)],
//            [v(0.4, .g), v(0.1, .g)],
//            [v(108.0, .g), v(16.0, .g)],
//            [v(79.0, .g), v(12.0, .g)],
//            [v(1.9, .g), v(0.3, .g)],
//            [v(5.5, .g), v(0.8, .g)],
//        ]
//    ],
//
//    "E7EFDA78-DC5B-4E4F-B82A-F04DBBE04577": [
//        [
//            [v(1258.0, .kj), v(1006.0, .kj)],
//            [v(6.2, .g), v(5.0, .g)],
//            [v(3.1, .g), v(2.5, .g)],
//            [v(49.0, .g), v(39.0, .g)],
//            [v(1.5, .g), v(1.2, .g)],
//            [v(9.3, .g), v(7.4, .g)],
//            [v(7.1, .g), v(5.7, .g)],
//            [v(1.0, .g), v(0.8, .g)],
//        ]
//    ],
//
//    "6C225FA4-44FF-45D7-B723-3AF4DD1D4E40": [
//        [
//            [v(746.0, .kj), v(488.0, .kj)],
//            [v(5.7, .g), v(3.8, .g)],
//            [v(0.0, .mg), v(0.0, .mg)],
//            [v(9.5, .g), v(6.3, .g)],
//            [v(6.2, .g), v(4.1, .g)],
//            [v(17.4, .g), v(11.6, .g)],
//            [v(17.1, .g), v(11.4, .g)],
//            [v(59.0, .mg), v(39.0, .mg)],
//            [v(213.0, .mg), v(142.0, .mg)],
//        ]
//    ],
//
//    "EDAA3E38-55CC-4202-8128-91A04883AB33": [
//        [
//            [v(489.0, .kj), v(405.0, .kj)],
//            [v(5.9, .g), v(4.9, .g)],
//            [v(18.1, .g), v(15.1, .g)],
//            [v(18.1, .g), v(15.1, .g)],
//            [v(2.2, .g), v(1.8, .g)],
//            [v(1.4, .g), v(1.2, .g)],
//            [v(0.1, .g), v(0.1, .g)],
//            [v(0.1, .g), v(0.1, .g)],
//            [v(0.2, .g), v(0.2, .g)],
//            [v(223.0, .mg), v(186.0, .mg)],
//        ]
//    ],
//
//    "38F77747-253E-4E3B-A5E9-D74B4EE2CBC0": [
//        [
//            [v(396.0, .kj), v(495.0, .kj)],
//            [v(3.5, .g), v(4.4, .g)],
//            [v(12.8, .g), v(16.0, .g)],
//            [v(12.7, .g), v(15.9, .g)],
//            [v(3.2, .g), v(4.0, .g)],
//            [v(2.0, .g), v(2.5, .g)],
//            [v(2.0, .g), v(2.5, .g)],
//            [v(0.06, .g), v(0.08, .g)],
//            [v(0.2, .g), v(0.2, .g)],
//            [v(128.0, .mg), v(160.0, .mg)],
//        ]
//    ],
//
//    "B1B04BC0-212D-442E-AF10-2F860400AE45": [
//        [
//            [v(136.0, .kj), v(754.0, .kj)],
//            [v(0.0, .g), v(0.0, .g)],
//            [v(0.0, .g), v(0.0, .g)],
//            [v(0.0, .g), v(0.0, .g)],
//            [v(7.8, .g), v(43.5, .g)],
//            [v(6.8, .g), v(37.9, .g)],
//            [v(0.2, .g), v(0.8, .g)],
//            [v(320.0, .mg), v(1790.0, .mg)],
//            [v(0.8, .g), v(4.5, .g)],
//        ]
//    ],
//
//    "2A79F2EC-9A9D-4CF0-B06A-8A634B7C61B1": [
//        [
//            [v(1859.0, .kj), v(279.0, .kj)],
//            [v(0.6, .g), v(0.1, .g)],
//            [v(0.4, .g), v(0.1, .g)],
//            [v(108.0, .g), v(16.0, .g)],
//            [v(79.0, .g), v(12.0, .g)],
//            [v(1.9, .g), v(0.3, .g)],
//            [v(5.5, .g), v(0.8, .g)],
//        ]
//    ],
//
//    "6F8BBF90-AD9D-460C-B0D2-AD5C7FEE08B7": [
//        [
//            [v(330.0, .kj), v(2170.0, .kj)],
//            [v(0.8, .g), v(5.1, .g)],
//            [v(4.5, .g), v(28.9, .g)],
//            [v(2.8, .g), v(18.0, .g)],
//            [v(8.7, .g), v(56.8, .g)],
//            [v(7.1, .g), v(46.4, .g)],
//            [v(7.0, .mg), v(43.0, .mg)],
//        ]
//    ],
//
//    "B4586BDA-ED82-446D-B4F8-5D42EC618A83": [
//        [
//            [v(1068.0, .kj), v(534.0, .kj)],
//            [v(14.7, .g), v(7.4, .g)],
//            [v(7.9, .g), v(4.0, .g)],
//            [v(27.7, .g), v(13.9, .g)],
//            [v(22.4, .g), v(11.2, .g)],
//            [v(0.3, .g), v(0.2, .g)],
//            [v(3.0, .g), v(1.5, .g)],
//            [v(0.13, .g), v(0.06, .g)],
//        ]
//    ],
//
//    "C132B648-8974-457A-8EE6-824688D901EA": [
//        [
//            [v(395.0, .kj), v(315.0, .kj)],
//            [v(5.4, .g), v(4.3, .g)],
//            [v(0.1, .g), v(0.1, .g)],
//            [v(0.1, .g), v(0.1, .g)],
//            [v(0.0, .g), v(0.0, .g)],
//            [v(4.0, .mg), v(3.0, .mg)],
//            [v(17.8, .g), v(14.2, .g)],
//            [v(0.1, .g), v(0.1, .g)],
//            [v(84.0, .mg), v(67.0, .mg)],
//            [v(225.0, .mg), v(180.0, .mg)],
//        ]
//    ],
    
    //MARK: - Failing

    "A049E005-AB5E-4474-92B2-979EBC347FB5": [
        [
            [v(553.0, .kj)],
            [v(9.5, .g)],
            [v(5.9, .g)],
            [v(7.3, .g)],
            [v(6.8, .g)],
            [v(0.5, .g)],
            [v(4.3, .g)],
            [v(0.2, .g)]
        ]
    ],

//    "21AB8151-540A-41A9-BAB2-8674FD3A46E7": [
//        [
//            [v(46.0, .kj), v(297.0, .kj)],
//            [v(0.0, .g), v(0.0, .g)],
//            [v(0.0, .g), v(0.0, .g)],
//            [v(0.0, .g), v(0.0, .g)],
//            [v(0.0, .mg), v(0.0, .mg)],
//            [v(1.2, .g), v(8.1, .g)],
//            [v(1.2, .g), v(8.1, .g)],
//            [v(0.0, .g), v(0.0, .g)],
//            [v(1.5, .g), v(9.7, .g)],
//            [v(1590.0, .mg), v(10605.0, .mg)],
//            [v(4.0, .g), v(26.5, .g)],
//        ]
//    ],
//
//    "C05EDF6E-BB82-49FB-B745-1B8984987762": [
//        [
//            [v(1404.0, .kj), v(351.0, .kj)],
//            [v(6.8, .g), v(2.0, .g)],
//            [v(75.0, .g), v(19.0, .g)],
//            [v(47.3, .g), v(11.8, .g)],
//            [v(0.1, .g), v(0, .g)],
//            [v(0.1, .g), v(0, .g)],
//            [v(0, .g), v(0, .g)],
//            [v(20.0, .mg), v(5, .mg)],
//        ]
//    ],
//
//    "7E6948F3-3CBC-4DE3-8E18-7FD2E9EFD79E": [
//        [
//            [v(256.0, .kj), v(320.0, .kj)],
//            [v(4.9, .g), v(6.1, .g)],
//            [v(6.9, .g), v(8.6, .g)],
//            [v(6.9, .g), v(8.6, .g)],
//            [v(0.0, .g), v(0.0, .g)],
//            [v(1.5, .g), v(1.9, .g)],
//            [v(0.9, .g), v(1.1, .g)],
//            [v(0.4, .g), v(0.5, .g)],
//            [v(0.0, .g), v(0.0, .g)],
//            [v(0.0, .g), v(0.0, .g)],
//            [v(0.2, .g), v(0.3, .g)],
//            [v(0.08, .g), v(0.1, .g)],
//            [v(168.0, .mg), v(210.0, .mg)],
//        ]
//    ],
//
//    "22801297-A39C-4F80-AE1D-858AA6A68DDC": [
//        [
//            [v(136.0, .kj), v(754.0, .kj)],
//            [v(0.0, .g), v(0.0, .g)],
//            [v(0.0, .g), v(0.0, .g)],
//            [v(0.0, .g), v(0.0, .g)],
//            [v(7.8, .g), v(43.5, .g)],
//            [v(6.8, .g), v(37.9, .g)],
//            [v(0.2, .g), v(0.8, .g)],
//            [v(320.0, .mg), v(1790.0, .mg)],
//            [v(0.8, .mg), v(4.5, .g)],
//        ]
//    ],
//
//    "0748DBAE-1379-40CF-A29C-0D342F53E7E3": [
//        [
//            [v(46.0, .kj), v(297.0, .kj)],
//            [v(0.0, .g), v(0.0, .g)],
//            [v(0.0, .g), v(0.0, .g)],
//            [v(0.0, .g), v(0.0, .g)],
//            [v(0.0, .mg), v(0.0, .mg)],
//            [v(1.2, .g), v(8.1, .g)],
//            [v(1.2, .g), v(8.1, .g)],
//            [v(0.0, .g), v(0.0, .g)],
//            [v(1.5, .g), v(9.7, .g)],
//            [v(1590.0, .mg), v(10605.0, .mg)],
//            [v(4.0, .g), v(26.5, .g)],
//        ]
//    ],
//
//    "A4DC9A58-AE29-4C79-A364-827470D60DD6": [
//        [
//            [v(460.0, .kj), v(2218.0, .kj)],
//            [v(6.0, .g), v(28.0, .g)],
//            [v(2.5, .g), v(13.0, .g)],
//            [v(0.0, .g), v(0.0, .g)],
//            [v(0.0, .g), v(2.0, .g)],
//            [v(13.0, .g), v(66.0, .g)],
//            [v(3.0, .g), v(15.0, .g)],
//            [v(1.0, .g), v(5.0, .g)],
//            [v(130.0, .mg), v(650.0, .mg)],
//        ]
//    ],
    
//
//    "99D1A080-19CF-4A08-B8B7-1BD5E4D9CB40": nil,
//    "3C53CC91-34D1-46EE-92BE-328ABDC20342": nil,
//    "15C9C2C9-5012-43A3-835A-3FB0A2DD1E2D": nil,
//    "0D04AEB7-95B1-4781-AFCA-38BF1036DAAC": nil,
//    "26F3916F-B688-49CC-A0DD-4F757B6735FD": nil,
//    "B3DC8D45-2F10-41C8-ACDF-2A00AFE6E0D3": nil,
//    "0A321001-BD7F-4A8A-8F62-FDE636B64CE3": nil,
//    "749A730F-17B1-47DE-9A5B-129C152D657E": nil,
//    "AE8C75F6-D65E-4F5F-A2D9-47FC81C158B9": nil,
//    "0494F267-A8C9-4796-8D23-DA6098C1AA5B": nil,
//    "BF1EE7E6-96C0-4929-8F9B-C3E4EC7782F2": nil,
//    "DF58E0D9-56BF-404C-8B36-675F797411A6": nil,
//    "0CBD5EF1-01E2-482E-891D-21A32479CFB0": nil,
//    "91F8FEFC-DF56-492D-BAB0-3EC24ADB84F3": nil,
//    "FCA442D0-9F3A-4AF9-9460-D3075C7FB2A0": nil,
//    "D65B73DA-E3E0-4968-83EF-06EA3E629A20": nil,
//    "6C3008A5-A6B0-438D-9332-827B52421643": nil,
//    "CC5957B2-1208-4A85-A728-5EABA1348DB9": nil,
//    "BB071452-B8C0-492D-890E-122BDBBF5909": nil,
//    "D3E7433B-AF49-4ACB-84EC-8366795CE048": nil,
//    "18E7934B-8B75-4E60-A041-7837D1E3DC27": nil,
//    "3A7D1894-FD50-4226-8A97-8471F4E34E89": nil,
//    "4CF0CBA5-C746-4844-BF54-27A92C808280": nil,
//    "5410D64B-4A8D-4183-8C81-EC82ABBFA648": nil,
//    "B789ED71-802F-42EF-85A5-FD9FEED77E6F": nil,
//    "083C5BAA-2DDA-42E5-8A6C-DCD1A3E5B7E1": nil,
//    "CE17DE0B-1480-4195-ACD0-C706FF9EE86F": nil,
//    "9CFDEE5E-005E-408F-B1E5-2EF751747988": nil,
//    "85025F31-4CD8-48D5-8AB0-246D8EAF0465": nil,
//    "9BA54F68-9FC5-430B-90C2-158A2BD1B29D": nil,
//    "90520604-4AF2-4C16-8C5E-F522F2309ECE": nil,
//    "92C3B115-CBED-4E4D-B831-4BF7BF973BCD": nil,
//    "674347E4-7B53-4409-95AF-07FD0560ADBA": nil,
//    "0E6CBF93-F98E-4922-8058-CE987BBD9617": nil,
//    "B362A01E-8762-4BD4-B7E9-ACED4D919B5B": nil,
//    "4527F77A-3514-4EAB-9DC1-214D10BBE9BA": nil,
//    "2E51C3CE-7363-412E-AF68-EB3F3ED9B343": nil,
//    "662AD301-6914-49EE-B8D2-DAFE00AF7F7F": nil,
//    "DE38ABA0-A8D7-46A5-8DBB-7E2DE983F9F4": nil,
//    "180F6D30-B077-4787-BE2C-22D3C4FC00E3": nil,
//    "1B9397C9-27E5-4E9F-BE75-17C878A2F323": nil,
//    "40E7C0B9-E9CC-4FA7-93A3-B3623FAB23FF": nil,
//    "7A7E14B8-EFA8-4140-987F-65439B83D99A": nil,
//    "713A721E-A470-4DA8-B44E-E939FEF9777A": nil,
//    "BD53EFF6-2AF9-4FCA-8865-67CCB4BA9B69": nil,
//    "D8809685-A90E-4756-BCA1-79B2D8C0D090": nil,
]

//let SingledOutTestCase: UUID? = nil

let SingledOutTestCase: UUID? = UUID(uuidString: "C132B648-8974-457A-8EE6-824688D901EA")!

let TestPassingTestCases = true

