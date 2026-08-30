Japanese instructions below English 

What is this tool?
"Darucoma" is for making the "darui" (boring) task of taking screenshots of storyboards, much faster. This is a tool mainly intended for artists working in 3D or 2D layout. It is basically an upgraded snipping tool which automatically create folder structures for cuts, saves the screenshots to a specify file path, and names and sorts them them according to the episode, cut, and panel number for the scene you need to work on.

Why did I make it?
During my time working in a studio in Japan on a television anime production, I did some work on 3D layouts. In order to closely match the storyboards, I was required to save each storyboard panel as a .png before importing them into blender, and the only way my studio did it was by using snipping tool and manually screenshotting and saving each individual panel to the file path they wanted. It felt like a complete waste of time, and I couldn't find a tool online to speed it up so I decided to make my own in godot.
I hope by sharing it, I can save some time for artists, so they can spend more time creating and less time doing mindless labour.

Requirements:
Windows or mac system, storyboard file saved as pdf or some format you can scroll on WITHOUT needing the tab in focus.

Installation:
Go to releases, download exe file, or the zip file and extract it. When you first launch it you may need to give it access to run. 
For mac users, download the mac build zip and extract. You will need to allow it to run in security settings and then also give it permissions to take screenshots of your screen.

Usage guide:

1. Input path you want to SAVE your screenshots into the first text box.
To get the path, either enter it manually, or in file browser, right click the address bar and press "copy address" and then paste it in the input box.
correct path format should look something like this: C:\document\anime_name\storyboard_cuts\episode1
The format will be slightly different for mac.

2. Input episode number into the next box, like 1, or 2, or maybe even 3...

3. You can toggle to use a custom range of cuts you want to screenshot. If it is on, manually input the range you want into the next text box. Please use standard commas and hyphens, if you are on a Japanese keyboard, you may need to toggle half width characters.
   
4. You have not have toggles to specify in what folder format you want the screenshots to be saved. The folders will save into your input path, and then the screenshots you take will be automatically sorted into them if the option is on.
   
5. Press start to start taking screenshots. It will make the relevant folders now

6. Now you can begin to take screenshots. In order to take a screenshot you must have Darucoma's UI IN FOCUS, and be in screenshot mode by pressing "s". If you need to scroll down your storyboard document, un-toggle screenshot mode (s), scroll, and then re-toggle it to take screenshots again.
   Drag and release to take a screenshot, or cancel it by pressing right click.
   The screenshot will save in .png files in the path you inputted, and the cut range folder (if enabled). They will save in the format EpisodeNumber_CutNumber-PanelNumber e.g. ep 5 cut 2 panel 3 is 05_002-3
   if file path set up correctly, screenshots will be saved in folder structure like this in the path you inputted earlier
  
  the panel number will automatically increase when you take a screenshot. When you have finished the cut, press "d" to move onto the next cut.
  Other hotkeys are
  "a" to decrease cut number
  "e" to increase panel number
  "q" to decrease panel number
  "esc" to exit and go back to previous screen.

7. (optional) Screenshot assist can make the process faster. Set a custom aspect ration to lock the screenshot size to that, or set a default size to lock all screenshots to a fixed size. If needed to change it for a pan or zoom, just disable it and then re-enable it when done.
   

Important:
Beta build so still may have issues. Please report them to be via email or github if you find any. 
I would appreciate any feedback whatsoever, so please get intouch if you use this tool.

このツールは何ですか？
「Darucoma」は、絵コンテのスクリーンショットを撮るだるいなタスクをずっと高速化するためのツールです。このツールは主に3Dまたは2Dレイアウトで作業するアーティスト向けです。基本的には強化されたスニッピングツールで、カットの フォルダ構造を自動的に作成し、スクリーンショットを指定されたファイルパスに保存し、作業するシーンのエピソード、カット、パネル番号に従って名前を付けてソートします。

なぜ私はこれを作ったのか？
日本のスタジオでテレビアニメ制作に携わっていた間、3Dレイアウトの仕事をしていました。絵コンテに密接にマッチさせるために、各絵コンテパネルを.png形式で保存してからBlenderにインポートする必要がありました。スタジオではスニッピングツールを使用して、各パネルを手動でスクリーンショットし、希望するファイルパスに保存するだけでした。これは完全な時間の無駄に思えたので、オンラインでこのプロセスをスピードアップするツールが見つからず、Godotで自分のツールを作ることにしました。
このツールを共有することで、アーティストの時間を節約でき、退屈な作業ではなく、創造性に時間を費やすことができることを願っています。

必要な環境：
Windows またはmacシステム、絵コンテファイルがpdfまたはタブにフォーカスを当てる必要なくスクロールできる形式で保存されていること。

インストール：
リリースページに移動して、exeファイルをダウンロードするか、zipファイルをダウンロードして抽出します。初めて起動する場合、実行権限を与える必要がある場合があります。
macユーザーは、macビルドzipをダウンロードして抽出してください。セキュリティ設定で実行を許可し、画面のスクリーンショットを撮影する権限も与える必要があります。

使用方法：

スクリーンショットを保存したいパスを最初のテキストボックスに入力してください。
パスを取得するには、手動で入力するか、ファイルブラウザでアドレスバーを右クリックして「アドレスをコピー」を押し、入力ボックスに貼り付けます。
正しいパス形式は以下のようになります：C:\document\anime_name\storyboard_cuts\episode1
macの場合は形式が少し異なります。
次のボックスにエピソード番号を入力してください。例えば、1、2、または3など...
スクリーンショットを撮影したいカットのカスタム範囲を使用するようにトグルできます。オンの場合、次のテキストボックスに希望する範囲を手動で入力してください。標準のコンマとハイフンを使用してください。日本語キーボードを使用している場合は、半角文字に切り替える必要があります。
スクリーンショットを保存するフォルダ形式を指定するトグルがあります。フォルダは入力されたパスに保存され、オプションがオンの場合、撮影したスクリーンショットは自動的にそれらにソートされます。
「開始」を押してスクリーンショットの撮影を開始します。関連するフォルダが作成されます。
これでスクリーンショットの撮影を開始できます。スクリーンショットを撮影するには、Darucomaのユーザーインターフェースが「フォーカス内」である必要があり、「s」キーを押してスクリーンショットモードにする必要があります。絵コンテドキュメントをスクロールダウンする必要がある場合は、スクリーンショットモード（s）をオフにして、スクロールしてから、再度オンにしてスクリーンショットを撮影してください。
ドラッグしてリリースしてスクリーンショットを撮影するか、右クリックでキャンセルします。
スクリーンショットは.png形式で、入力されたパスとカット範囲フォルダ（有効な場合）に保存されます。形式はエピソード番号_カット番号-パネル番号で保存されます。例えば、エピソード5、カット2、パネル3の場合は05_002-3です。
ファイルパスが正しく設定されている場合、スクリーンショットは以前に入力されたパスに次のようなフォルダ構造で保存されます。

パネル番号はスクリーンショットを撮影するたびに自動的に増加します。カットが終わったら、「d」を押して次のカットに進みます。
その他のホットキーは
「a」カット番号を減少
「e」パネル番号を増加
「q」パネル番号を減少
「esc」を終了して前の画面に戻ります。

（オプション）スクリーンショットアシストはプロセスをより高速化できます。スクリーンショットサイズをロックするカスタムアスペクト比を設定するか、すべてのスクリーンショットを固定サイズにロックするデフォルトサイズを設定します。パンやズーム用に変更する必要がある場合は、無効にしてから、完了したら再度有効にしてください。

重要事項：
ベータ版ビルドなので、まだ問題がある可能性があります。問題が見つかった場合は、メールまたはGitHubを通じてお知らせください。
このツールを使用していただける場合は、何らかのフィードバックをいただければ幸いです。お気軽にお問い合わせください。
