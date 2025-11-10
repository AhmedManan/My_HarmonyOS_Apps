// PoemList.ets
import router from '@ohos.router';
import { Poem, poemData, getPoetById } from '../data/PoemData';

@Entry
@Component
struct PoemList {
  @State filteredPoems: Poem[] = poemData;
  @State searchText: string = '';

  build() {
    Column() {
      // App Title
      Text('Bangla Kids Poem')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)
        .padding({ bottom: 10 })
        .alignSelf(ItemAlign.Center)

      // Search Bar (without back button)
      TextInput({ placeholder: 'কবিতা বা কবি খুঁজুন...' })
        .width('100%')
        .height(50)
        .margin({ bottom: 10 })
        .fontSize(18)
        .onChange((value: string) => {
          this.searchText = value;
          this.filterPoems();
        })

      // Poem List
      List({ space: 10 }) {
        ForEach(this.filteredPoems, (poem: Poem) => {
          ListItem() {
            Column() {
              // Poem Title
              Text(poem.title)
                .fontSize(20)
                .fontWeight(FontWeight.Bold)
                .fontColor(Color.Black)
                .margin({ bottom: 5 })

              // Poet Name (clickable)
              Row() {
                Text('কবি: ')
                  .fontSize(16)
                  .fontColor('#666666')

                Text(getPoetById(poem.poetId)?.name || '')
                  .fontSize(16)
                  .fontColor('#1E88E5')
                  .onClick(() => {
                    router.push({
                      url: 'pages/PoetDetail',
                      params: { poetId: poem.poetId.toString() }
                    });
                  })
              }
              .margin({ bottom: 5 })

              // Preview of content
              if (poem.content) {
                Text(poem.content.split('\n')[0].substring(0, 50) + '...')
                  .fontSize(14)
                  .fontColor('#757575')
              }
            }
            .width('100%')
            .padding(15)
            .backgroundColor(Color.White)
            .borderRadius(10)
            .shadow({ radius: 2, color: '#000000', offsetX: 1, offsetY: 1 })
          }
          .onClick(() => {
            router.push({
              url: 'pages/PoemDetail',
              params: { poemId: poem.id.toString() }
            });
          })
        }, (poem: Poem) => poem.id.toString())
      }
      .width('100%')
      .layoutWeight(1)

      // Bottom Buttons
      Row({ space: 20 }) {
        Button('Poet List')
          .width('45%')
          .height(50)
          .fontSize(18)
          .backgroundColor('#1E88E5')
          .fontColor(Color.White)
          .borderRadius(8)
          .onClick(() => {
            router.push({
              url: 'pages/PoetList'
            });
          })

        Button('Credit Page')
          .width('45%')
          .height(50)
          .fontSize(18)
          .backgroundColor('#6D4C41')
          .fontColor(Color.White)
          .borderRadius(8)
          .onClick(() => {
            router.push({
              url: 'pages/CreditsPage'
            });
          })
      }
      .margin({ top: 10 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
    .padding(10)
  }

  filterPoems() {
    if (this.searchText === '') {
      this.filteredPoems = [...poemData];
    } else {
      const query = this.searchText.toLowerCase();
      this.filteredPoems = poemData.filter(poem => {
        const poet = getPoetById(poem.poetId);
        return (
          poem.title.toLowerCase().includes(query) ||
            (poet?.name.toLowerCase().includes(query)) ||
          poem.content.toLowerCase().includes(query)
        );
      });
    }
  }
}
