// PoetList.ets
import router from '@ohos.router';
import { Poet, poetData, getPoemsByPoetId } from '../data/PoemData';

@Entry
@Component
struct PoetList {
  @State filteredPoets: Poet[] = poetData;
  @State searchText: string = '';

  build() {
    Column() {
      // Search Bar with Back Button
      Row({ space: 10 }) {
        Image($r('app.media.back'))
          .width(30)
          .height(30)
          .margin({ right: 10 })
          .onClick(() => {
            router.back();
          })

        // Search Input
        TextInput({ placeholder: 'কবি খুঁজুন...' })
          .layoutWeight(1) // Takes remaining space
          .height(50)
          .fontSize(18)
          .onChange((value: string) => {
            this.searchText = value;
            this.filterPoets();
          })
      }
      .width('90%')
      .margin(10)
      .alignItems(VerticalAlign.Center)

      // Poet List
      List({ space: 10 }) {
        ForEach(this.filteredPoets, (poet: Poet) => {
          ListItem() {
            Column() {
              // Poet Name
              Text(poet.name)
                .fontSize(20)
                .fontWeight(FontWeight.Bold)
                .fontColor(Color.Black)
                .margin({ bottom: 5 })

              // Poem Count
              Text(`কবিতা: ${getPoemsByPoetId(poet.id).length} টি`)
                .fontSize(14)
                .fontColor('#1E88E5')
            }
            .width('100%')
            .padding(15)
            .backgroundColor(Color.White)
            .borderRadius(10)
            .shadow({ radius: 2, color: '#000000', offsetX: 1, offsetY: 1 })
          }
          .onClick(() => {
            router.pushUrl({
              url: 'pages/PoetDetails',
              params: { poetId: poet.id.toString() }
            }).catch((err: Error) => {
              console.error('Navigation error:', err.message);
            });
          })
        }, (poet: Poet) => poet.id.toString())
      }
      .width('100%')
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
    .padding(10)
  }

  filterPoets() {
    if (this.searchText === '') {
      this.filteredPoets = [...poetData];
    } else {
      const query = this.searchText.toLowerCase();
      this.filteredPoets = poetData.filter(poet =>
      poet.name.toLowerCase().includes(query) ||
      poet.bio.toLowerCase().includes(query)
      );
    }
  }
}