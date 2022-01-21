from typing import List
from kitty.boss import Boss, Tab, Window
from kittens.tui.handler import result_handler
import json

def main(args):
    pass

@result_handler(no_ui=True)
def handle_result(args: List[str], answer: str, target_window_id: int, boss: Boss) -> str:
    result = ""
    for t in boss.all_tabs:
        result += tab_to_session_syntax(t)
    
    if len(args) == 2:
        output_filename = args[1]
        with open(output_filename, "w") as output_file:
            output_file.write(result)
            return
    return result

def tab_to_session_syntax(t: Tab) -> str:
    result = f"# tab: {t.name}\n"
    lines = [
        f"new_tab {t.name}",
        f"enabled_layouts {', '.join(t.enabled_layouts)}",
        f"layout {t.current_layout.name}",
        f"cd {t.cwd}",
    ]
    result += '\n'.join(lines)
    for w in t.windows:
        result += '\n' + window_to_session_syntax(w)
    result += "\n\n"
    return result

def window_to_session_syntax(w: Window) -> str:
    result = f"# window: {w.title}\n"
    result += f"launch --cwd {w.cwd_of_child}"
    if w.override_title:
        # Only set the override title if the window has one
        result += f" --title {w.override_title}"
    result +=f" {' '.join(w.child.cmdline)}"
    return result
