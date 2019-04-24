import React from 'react'
import { Menu } from 'semantic-ui-react'
import { connect } from 'react-redux'
import { setActiveItem } from '../redux/actions'


const TrendingMenu = props => {
  const { activeItem } = props.activeItem

  return (
    <div id='menu-container'>
      <Menu tabular id='trending-menu'>
        <Menu.Item name='Popular' active={activeItem === 'Popular'} onClick={() => props.setActiveItem('likes') } />
        <Menu.Item name='UnPopular' active={activeItem === 'UnPopular'} onClick={() => props.setActiveItem('dislikes')}/>
        <Menu.Item name='Controversial' active={activeItem === 'Controversial'} onClick={() => props.setActiveItem('controversial')} />
      </Menu>
    </div>
  )
}

const mapStateToProps = state => ({
  activeItem: state.activeItem
})

const mapDispatchToProps = dispatch => ({
  setActiveItem: (item) => dispatch(setActiveItem(item))
})

export default connect(mapStateToProps, mapDispatchToProps)(TrendingMenu)