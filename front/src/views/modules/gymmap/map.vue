<template>
  <div class="main-content">
    <div class="gymmap-container">
      <div class="title">附近健身房</div>
      <div class="content-wrapper">
        <div class="gym-list">
          <div class="list-header">
            <span>健身房列表</span>
            <span class="total">共 {{ gyms.length }} 家</span>
          </div>
          <div class="list-content">
            <div 
              v-for="(gym, index) in gyms" 
              :key="index" 
              class="gym-item"
              :class="{ active: activeIndex === index }"
              @click="focusGym(index)"
            >
              <div class="gym-header">
                <div class="gym-name">{{ gym.name }}</div>
                <div class="gym-badge">{{ gym.district }}</div>
              </div>
              <div class="gym-info">
                <div class="info-row">
                  <i class="el-icon-location"></i>
                  <span>{{ gym.address }}</span>
                </div>
                <div class="info-row">
                  <i class="el-icon-phone"></i>
                  <span>{{ gym.phone }}</span>
                </div>
              </div>
              <div class="gym-actions">
                <el-button type="primary" size="mini" @click.stop="openNavigation(gym)">
                  <i class="el-icon-location-information"></i> 导航
                </el-button>
                <el-button type="success" size="mini" @click.stop="viewOnMap(gym)">
                  <i class="el-icon-view"></i> 查看
                </el-button>
              </div>
            </div>
          </div>
        </div>
        <div class="map-wrapper">
          <div id="amap-container" class="map-box"></div>
          <div class="location-btn" @click="getUserLocation">
            <i class="el-icon-location"></i>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      map: null,
      activeIndex: -1,
      markers: [],
      infoWindow: null,
      userLocationMarker: null,
      // 兰州各区健身房位置数据
      gyms: [
        { name: '健身中心（城关店）', address: '兰州市城关区东方红广场', phone: '0931-88888888', position: [103.838, 36.061], district: '城关区' },
        { name: '健身中心（西固店）', address: '兰州市西固区西固城', phone: '0931-88888889', position: [103.622, 36.086], district: '西固区' },
        { name: '健身中心（七里河店）', address: '兰州市七里河区西站', phone: '0931-88888880', position: [103.735, 36.062], district: '七里河区' },
        { name: '健身中心（安宁店）', address: '兰州市安宁区培黎广场', phone: '0931-88888881', position: [103.718, 36.113], district: '安宁区' },
        { name: '健身中心（红古店）', address: '兰州市红古区海石湾', phone: '0931-88888882', position: [102.852, 36.343], district: '红古区' },
        { name: '健身中心（永登店）', address: '兰州市永登县城关镇', phone: '0931-88888883', position: [103.255, 36.736], district: '永登县' },
        { name: '健身中心（榆中店）', address: '兰州市榆中县城关镇', phone: '0931-88888884', position: [104.138, 35.844], district: '榆中县' },
        { name: '健身中心（皋兰店）', address: '兰州市皋兰县城关镇', phone: '0931-88888885', position: [103.952, 36.032], district: '皋兰县' },
      ]
    };
  },
  mounted() {
    this.$nextTick(() => {
      this.initMap();
    });
  },
  methods: {
    initMap() {
      // 等待DOM渲染完成
      setTimeout(() => {
        if (!document.getElementById('amap-container')) {
          return;
        }
        
        // 初始化地图，中心点设为兰州
        this.map = new AMap.Map('amap-container', {
          zoom: 10,
          center: [103.838, 36.061],
          mapStyle: 'amap://styles/normal'
        });

        // 添加标记点
        this.gyms.forEach((gym, index) => {
          const marker = new AMap.Marker({
            position: new AMap.LngLat(gym.position[0], gym.position[1]),
            title: gym.name,
            icon: new AMap.Icon({
              size: new AMap.Size(32, 32),
              image: 'https://a.amap.com/jsapi_demos/static/demo-center/icons/poi-marker-default.png',
              imageSize: new AMap.Size(32, 32)
            })
          });

          // 点击标记显示信息窗体
          marker.on('click', () => {
            this.activeIndex = index;
            this.showInfoWindow(gym, marker.getPosition());
          });

          this.markers.push(marker);
          this.map.add(marker);
        });

        // 创建信息窗体
        this.infoWindow = new AMap.InfoWindow({
          isCustom: false,
          offset: new AMap.Pixel(0, -30)
        });
      }, 100);
    },
    showInfoWindow(gym, position) {
      const content = this.createInfoWindowContent(gym);
      this.infoWindow.setContent(content);
      this.infoWindow.open(this.map, position);
    },
    createInfoWindowContent(gym) {
      return `
        <div style="padding: 15px; min-width: 220px; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); border-radius: 8px; color: #fff;">
          <h4 style="margin: 0 0 10px 0; color: #fff; font-size: 16px;">${gym.name}</h4>
          <p style="margin: 5px 0; font-size: 13px; color: rgba(255,255,255,0.9);">
            <span style="display:inline-block;width:40px;">区域：</span>${gym.district}
          </p>
          <p style="margin: 5px 0; font-size: 13px; color: rgba(255,255,255,0.9);">
            <span style="display:inline-block;width:40px;">地址：</span>${gym.address}
          </p>
          <p style="margin: 5px 0; font-size: 13px; color: rgba(255,255,255,0.9);">
            <span style="display:inline-block;width:40px;">电话：</span>${gym.phone}
          </p>
          <div style="margin-top: 12px; text-align: center;">
            <button onclick="window.open('https://uri.amap.com/marker?position=${gym.position[0]},${gym.position[1]}&name=${gym.name}&callnative=1','_blank')" 
                    style="background: #fff; color: #667eea; border: none; padding: 6px 16px; border-radius: 20px; cursor: pointer; font-size: 12px;">
              导航 →
            </button>
          </div>
        </div>
      `;
    },
    focusGym(index) {
      this.activeIndex = index;
      const gym = this.gyms[index];
      // 移动地图到该位置
      this.map.setZoomAndCenter(14, new AMap.LngLat(gym.position[0], gym.position[1]));
      // 显示信息窗体
      this.showInfoWindow(gym, new AMap.LngLat(gym.position[0], gym.position[1]));
    },
    viewOnMap(gym) {
      const index = this.gyms.indexOf(gym);
      this.focusGym(index);
    },
    openNavigation(gym) {
      // 使用高德地图网页版进行导航
      const url = `https://uri.amap.com/marker?position=${gym.position[0]},${gym.position[1]}&name=${gym.name}&address=${gym.address}&callnative=1`;
      window.open(url, '_blank');
    },
    getUserLocation() {
      const that = this;
      // 使用高德地图定位插件
      AMap.plugin(['AMap.Geolocation'], function() {
        const geolocation = new AMap.Geolocation({
          enableHighAccuracy: true,
          timeout: 10000,
          showMarker: true,
          showCircle: true,
          panToLocation: true,
          zoomToAccuracy: true
        });

        geolocation.getCurrentPosition(function(status, result) {
          if (status === 'complete' && result.info === 'OK') {
            const position = [result.position.lng, result.position.lat];
            
            // 如果已有定位标记，先移除
            if (that.userLocationMarker) {
              that.map.remove(that.userLocationMarker);
            }

            // 创建自定义定位标记（蓝色定位点）
            that.userLocationMarker = new AMap.Marker({
              position: new AMap.LngLat(position[0], position[1]),
              content: '<div style="width:16px;height:16px;background:#409EFF;border-radius:50%;border:3px solid #fff;box-shadow:0 2px 6px rgba(0,0,0,0.3);"></div>',
              offset: new AMap.Pixel(-8, -8)
            });

            // 添加定位点
            that.map.add(that.userLocationMarker);

            // 移动地图到定位位置
            that.map.setZoomAndCenter(13, new AMap.LngLat(position[0], position[1]));

            that.$message.success('定位成功');
          } else {
            // 尝试使用IP定位作为备选
            that.getLocationByIP();
          }
        });
      });
    },
    getLocationByIP() {
      const that = this;
      AMap.plugin(['AMap.CitySearch'], function() {
        const citySearch = new AMap.CitySearch();
        citySearch.getLocalCity(function(status, result) {
          if (status === 'complete' && result.info === 'OK') {
            // 获取城市中心点
            if (result.bounds) {
              const center = result.bounds.getCenter();
              that.map.setCenter([center.lng, center.lat]);
              that.map.setZoom(11);
              
              // 添加IP定位标记
              if (that.userLocationMarker) {
                that.map.remove(that.userLocationMarker);
              }
              that.userLocationMarker = new AMap.Marker({
                position: new AMap.LngLat(center.lng, center.lat),
                content: '<div style="width:16px;height:16px;background:#E6A23C;border-radius:50%;border:3px solid #fff;box-shadow:0 2px 6px rgba(0,0,0,0.3);"></div>',
                offset: new AMap.Pixel(-8, -8)
              });
              that.map.add(that.userLocationMarker);
              
              that.$message.success('已定位到您所在城市：' + result.city);
            }
          } else {
            that.$message.error('定位失败，请手动选择位置');
          }
        });
      });
    }
  }
};
</script>

<style lang="scss" scoped>
.gymmap-container {
  padding: 20px;
  height: calc(100vh - 100px);
  box-sizing: border-box;
  background: linear-gradient(135deg, #f5f7fa 0%, #e4e8ec 100%);
  border-radius: 12px;
  .title {
    font-size: 26px;
    font-weight: bold;
    text-align: center;
    margin-bottom: 20px;
    color: #333;
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
  }
  .content-wrapper {
    display: flex;
    gap: 20px;
    height: calc(100% - 60px);
    .gym-list {
      width: 380px;
      background: #fff;
      border-radius: 12px;
      box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
      overflow: hidden;
      display: flex;
      flex-direction: column;
      .list-header {
        padding: 16px 20px;
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: #fff;
        font-size: 16px;
        font-weight: 600;
        display: flex;
        justify-content: space-between;
        align-items: center;
        .total {
          font-size: 13px;
          opacity: 0.9;
        }
      }
      .list-content {
        flex: 1;
        overflow-y: auto;
        padding: 10px;
        &::-webkit-scrollbar {
          width: 6px;
        }
        &::-webkit-scrollbar-thumb {
          background: #c1c1c1;
          border-radius: 3px;
        }
        .gym-item {
          background: #f8f9fa;
          border-radius: 10px;
          padding: 16px;
          margin-bottom: 10px;
          cursor: pointer;
          transition: all 0.3s ease;
          border: 2px solid transparent;
          &:last-child {
            margin-bottom: 0;
          }
          &:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(102, 126, 234, 0.2);
          }
          &.active {
            border-color: #667eea;
            background: linear-gradient(135deg, rgba(102, 126, 234, 0.1) 0%, rgba(118, 75, 162, 0.1) 100%);
          }
          .gym-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 12px;
            .gym-name {
              font-size: 16px;
              font-weight: 600;
              color: #333;
            }
            .gym-badge {
              background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
              color: #fff;
              padding: 3px 10px;
              border-radius: 12px;
              font-size: 12px;
            }
          }
          .gym-info {
            margin-bottom: 12px;
            .info-row {
              display: flex;
              align-items: center;
              margin-bottom: 6px;
              font-size: 13px;
              color: #666;
              i {
                color: #667eea;
                margin-right: 8px;
                font-size: 14px;
              }
            }
          }
          .gym-actions {
            display: flex;
            gap: 10px;
            .el-button {
              flex: 1;
              border-radius: 20px;
            }
          }
        }
      }
    }
    .map-wrapper {
      flex: 1;
      border-radius: 12px;
      overflow: hidden;
      box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
      .map-box {
        width: 100%;
        height: 100%;
      }
      .location-btn {
        position: absolute;
        right: 20px;
        bottom: 30px;
        width: 44px;
        height: 44px;
        background: #fff;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        cursor: pointer;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
        z-index: 10;
        transition: all 0.3s ease;
        i {
          font-size: 20px;
          color: #409EFF;
        }
        &:hover {
          transform: scale(1.1);
          box-shadow: 0 4px 15px rgba(64, 158, 255, 0.4);
        }
      }
    }
  }
}

@media (max-width: 1200px) {
  .gymmap-container .content-wrapper {
    flex-direction: column;
    .gym-list {
      width: 100%;
      max-height: 300px;
    }
    .map-wrapper {
      height: 400px;
    }
  }
}
</style>
