/*
 Copyright 2016 Mozilla
 Licensed under the Apache License, Version 2.0 (the "License"); you may not use
 this file except in compliance with the License. You may obtain a copy of the 
 License at http://www.apache.org/licenses/LICENSE-2.0
 Unless required by applicable law or agreed to in writing, software distributed
 under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
 CONDITIONS OF ANY KIND, either express or implied. See the License for the
 specific language governing permissions and limitations under the License.
 */

import Foundation
import SwiftyJSON

class Bridge {
    func getDisplayList(width: Float, height: Float) -> JSON {
        let result = __get_display_list(width, height)
        let swift_result = String(cString: result!)
        let json = JSON(data: swift_result.data(using: .utf8)!)
        __free_display_list(UnsafeMutablePointer(mutating: result))
        return json
    }
}
