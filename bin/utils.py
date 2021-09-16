import numpy as np
import scipy.stats



UNITS = {
    'runtime_hr': 'hr',
    'memory_GB': 'GB',
    'disk_GB': 'GB'
}



def anomaly_score(y, y_loc, y_scale):
    y_anomaly = scipy.stats.norm.cdf(y, loc=y_loc, scale=y_scale)
    y_anomaly = 2 * (y_anomaly - 0.50)

    return y_anomaly



def check_std(y_pred):
    if isinstance(y_pred, tuple):
        return y_pred
    else:
        return y_pred, np.zeros_like(y_pred)



def predict_intervals(y_bar, y_std, n_stds=2.0):
    y_lower = y_bar - n_stds * y_std
    y_upper = y_bar + n_stds * y_std

    return y_lower, y_upper
