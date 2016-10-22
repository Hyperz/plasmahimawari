/*
 *  Copyright 2016 Hyperz
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  2.010-1301, USA.
 */

import QtQuick 2.0
import QtQuick.Controls 1.1
import QtQuick.Layouts 1.1

ColumnLayout {

    id: root

   Label {

        Layout.fillHeight: true
        Layout.fillWidth: true
        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

        text: "<br/>Images are provided by <a href=\"http://himawari8.nict.go.jp/\">himawari8.nict.go.jp</a>."
        onLinkActivated: Qt.openUrlExternally(link)

    }

}
