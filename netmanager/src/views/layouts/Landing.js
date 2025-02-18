import React, { Component } from 'react';
import { Link } from 'react-router-dom';
import PropTypes from 'prop-types';
import { connect } from 'react-redux';
import AlertMinimal from './AlertsMininal';

class Landing extends Component {
  componentDidMount() {
    if (this.props.auth.isAuthenticated) {
      this.props.history.push('/dashboard');
    }
  }

  render() {
    return (
      <AlertMinimal>
        <div style={{ height: '75vh' }} className="container valign-wrapper">
          <div className="row">
            <div className="col s12 center-align">
              <br />
              <div className="col s6">
                <Link
                  to="/request-access"
                  style={{
                    width: '140px',
                    borderRadius: '3px',
                    letterSpacing: '1.5px'
                  }}
                  className="btn btn-large waves-effect waves-light hoverable blue accent-3">
                  REQUEST
                </Link>
              </div>
              <div className="col s6">
                <Link
                  to="/login"
                  style={{
                    width: '140px',
                    borderRadius: '3px',
                    letterSpacing: '1.5px'
                  }}
                  className="btn btn-large btn-flat waves-effect white black-text">
                  Log In
                </Link>
              </div>
            </div>
          </div>
        </div>
      </AlertMinimal>
    );
  }
}

Landing.propTypes = {
  auth: PropTypes.object.isRequired
};
const mapStateToProps = (state) => ({
  auth: state.auth
});

export default connect(mapStateToProps, {})(Landing);
