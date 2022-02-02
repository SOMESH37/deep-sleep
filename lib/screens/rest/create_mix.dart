import 'package:deep_sleep/exporter.dart';
import 'package:deep_sleep/screens/rest/data.dart';

class CreateMix extends StatefulWidget {
  @override
  _CreateMixState createState() => _CreateMixState();
}

class _CreateMixState extends State<CreateMix> {
  late final _textCon = TextEditingController();
  @override
  void dispose() {
    _textCon.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: Dashboard.pad * 2),
            shrinkWrap: true,
            children: [
              const AutoSizeText(
                'Give your mix a name',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
                maxLines: 1,
                textAlign: TextAlign.center,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: Dashboard.pad * 2.5),
                child: TextSelectionTheme(
                  data: const TextSelectionThemeData(
                    cursorColor: Colours.elevationButton,
                    selectionColor: Colours.elevationButton,
                    selectionHandleColor: Colours.elevationButton,
                  ),
                  child: TextField(
                    autofocus: true,
                    controller: _textCon,
                    onChanged: (_) => setState(() {}),
                    cursorColor: Colours.elevationButton,
                    textAlign: TextAlign.center,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(32),
                      FilteringTextInputFormatter.allow(
                        RegExp('[0-9_.a-z A-Z]'),
                      ),
                    ],
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    textCapitalization: TextCapitalization.sentences,
                    keyboardType: TextInputType.name,
                    style: const TextStyle(fontSize: 24),
                    decoration: const InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colours.elevationButton),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colours.elevationButton),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: Dashboard.pad * 1.5),
              Row(
                children: List.generate(
                  2,
                  (i) {
                    final name = _textCon.text.lowerCaseWithoutSpace;
                    final isNameValid = !(HiveHelper.userMixesBox.keys.any(
                              (e) =>
                                  (e as String).lowerCaseWithoutSpace == name,
                            ) ||
                            RestTileData.items.any(
                              (e) => e.name.lowerCaseWithoutSpace == name,
                            )) &&
                        _textCon.text.length > 1 &&
                        // .isNotEmpty not working
                        _textCon.text.trim() != '';
                    return Expanded(
                      child: TextButton(
                        onPressed: () {
                          if (i == 0) {
                            return Navigator.pop(context);
                          } else if (isNameValid) {
                            Navigator.pushReplacement(
                              context,
                              EditPlaylist(
                                _textCon.text.trim(),
                                isEditing: false,
                              ).route,
                            );
                          }
                        },
                        style: TextButton.styleFrom(
                          minimumSize: const Size(double.maxFinite, 48),
                          primary: i == 1 && isNameValid
                              ? Colours.elevationButton
                              : null,
                        ),
                        child: Text(i == 0 ? 'Cancel' : 'Next'),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EditPlaylist extends StatefulWidget {
  const EditPlaylist(this.name, {this.isEditing = true});
  final String name;
  final bool isEditing;
  @override
  _EditPlaylistState createState() => _EditPlaylistState();
}

class _EditPlaylistState extends State<EditPlaylist> {
  late final List<String> _songs;
  @override
  void initState() {
    super.initState();
    _songs = List.from(HiveHelper.userMixesBox.get(widget.name) ?? []);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEditing ? widget.name : 'Add songs'),
        actions: widget.isEditing
            ? [
                IconButton(
                  onPressed: () {
                    HiveHelper.userMixesBox
                        .delete(widget.name)
                        .then((_) => HiveHelper.putFireStore(onlyMix: true));

                    Navigator.pop(context);
                  },
                  tooltip: 'Delete',
                  icon: const Icon(Icons.delete_forever_rounded),
                ),
              ]
            : [],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: Dashboard.pad / 2),
          children: [
            ReorderableListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              buildDefaultDragHandles: false,
              itemBuilder: (_, i) {
                final item =
                    RestTileData.items.firstWhere((e) => e.name == _songs[i]);
                return Semantics(
                  key: ValueKey(item.name),
                  child: EditPlaylistTile(
                    data: item,
                    index: i,
                    callback: () => setState(() => _songs.remove(item.name)),
                    isSelected: true,
                  ),
                );
              },
              itemCount: _songs.length,
              onReorder: (o, n) => setState(() {
                if (n > o) n--;
                _songs.insert(n, _songs.removeAt(o));
              }),
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (_, i) {
                final item = List<RestTileData>.from(
                  RestTileData.items
                      .where((e) => _songs.every((ele) => ele != e.name)),
                )[i];
                return EditPlaylistTile(
                  data: item,
                  index: i,
                  callback: () => setState(() => _songs.add(item.name)),
                );
              },
              itemCount: RestTileData.items.length - _songs.length,
              shrinkWrap: true,
            ),
          ],
        ),
      ),
      floatingActionButton: _songs.length > 1
          ? FloatingActionButton.extended(
              onPressed: () {
                HiveHelper.userMixesBox
                    .put(widget.name, _songs)
                    .whenComplete(() => HiveHelper.putFireStore(onlyMix: true));
                Navigator.pop(context);
              },
              label: const Text('Save'),
              icon: const Icon(Icons.save_rounded),
              foregroundColor: Colors.white,
              backgroundColor: Colours.elevationButton,
            )
          : null,
    );
  }
}

class EditPlaylistTile extends StatelessWidget {
  const EditPlaylistTile({
    required this.data,
    required this.index,
    required this.callback,
    this.isSelected = false,
  });
  final RestTileData data;
  final VoidCallback callback;
  final int index;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: callback,
      child: ReorderableDelayedDragStartListener(
        index: index,
        child: ColoredBox(
          color: Colours.scaffold.withOpacity(0.5),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: Dashboard.pad / 2,
              horizontal: Dashboard.pad,
            ),
            child: Row(
              children: [
                Container(
                  height: 64,
                  width: 64,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: DecorationImage(
                      opacity: isSelected ? 0.4 : 1,
                      fit: BoxFit.cover,
                      image: AssetImage(data.imgPath),
                    ),
                  ),
                  child: isSelected
                      ? IgnorePointer(
                          child: Transform.scale(
                            scale: 1.6,
                            child: Checkbox(
                              value: true,
                              onChanged: null,
                              shape: const CircleBorder(),
                              fillColor: MaterialStateProperty.all(
                                Colours.elevationButton,
                              ),
                            ),
                          ),
                        )
                      : null,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Txt.title(data.name),
                        Txt.body(data.artist),
                      ],
                    ),
                  ),
                ),
                ReorderableDragStartListener(
                  enabled: isSelected,
                  index: index,
                  child: Icon(
                    Icons.drag_handle_rounded,
                    color: isSelected ? null : Colors.white24,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
