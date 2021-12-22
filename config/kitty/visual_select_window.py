#!/usr/bin/env python
# License: GPLv3 Copyright: 2021, Daniel Lipovetsky <daniel.lipovetsky at gmail.com>
from typing import List, Optional
from kitty.boss import Boss
from kitty.tabs import Tab
from kitty.window import Window
from kittens.tui.handler import result_handler
import json

def main(args):
    pass

@result_handler(no_ui=True)
def handle_result(args: List[str], answer: str, target_window_id: int, boss: Boss) -> str:
    selector_tab = boss.active_tab
    if selector_tab == None:
        return
    selector_tab_current_layout = selector_tab.current_layout.name
    selector_tab_enabled_layouts = selector_tab.enabled_layouts
    # To allow visual selection while using 'stack' layout, temporarily use 'tall' layout
    if selector_tab_current_layout == 'stack':
        selector_tab_temporary_layout = 'tall'
        if selector_tab_temporary_layout not in selector_tab_enabled_layouts:
            selector_tab.set_enabled_layouts(selector_tab_temporary_layout + selector_tab_enabled_layouts)
        selector_tab.goto_layout(selector_tab_temporary_layout)

    def callback(tab: Optional[Tab], window: Optional[Window]) -> None:
        if tab:
            if window:
                tab.set_active_window(window)
        # Undo temporary layout change
        if selector_tab.current_layout.name != selector_tab_current_layout:
            selector_tab.goto_layout(selector_tab_current_layout)
        if selector_tab.enabled_layouts != selector_tab_enabled_layouts:
            selector_tab.set_enabled_layouts(selector_tab_enabled_layouts)

    boss.visual_window_select_action(selector_tab, callback, 'Choose window to switch to', only_window_ids=selector_tab.all_window_ids_except_active_window)
