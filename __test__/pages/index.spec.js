import { mount } from '@vue/test-utils'
import PagesIndex from '@/pages/index.vue'

describe('PagesIndex', () => {
  test('is a Vue instance', () => {
    const wrapper = mount(PagesIndex)
    expect(wrapper.isVueInstance()).toBeTruthy()
  })
})
